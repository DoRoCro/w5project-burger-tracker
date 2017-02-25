require_relative('./sql_runner.rb')

class Crud

#  # relies on
#  # - all object insance value name keys being strings (or symbols) matching column names
#  # - all tables / objects having 'id' as primary key / instance variable, which is returned from database on saving

# # Possible Future enhancement
    # put table creation code into here so can create tables based on ruby object instance variables??

# # CREATE METHODS

  def save()  
    sql = "INSERT INTO #{self.class.get_table_from_class} 
      ( #{self.get_table_fields}) 
      VALUES (#{self.get_values_list()}) RETURNING * ;"
    db_data = SqlRunner.run(sql)
    @id = db_data.first['id'].to_i
    self.arrays_to_save.each {|array| save_array_1_to_many(array, self)}
    return self.class.new(db_data.first)
  end

# # RETRIEVE METHODS

  def self.find_by_id(id)
    sql = "SELECT * FROM #{self.get_table_from_class} 
            WHERE id = #{id};"
    db_data = SqlRunner.run(sql)
    return self.new(db_data.first)
  end

  def self.get_many(sql)
    # result = SqlRunner.run(sql).map { |x| self.new(x)}   # fails if none found
    db_data = SqlRunner.run(sql)
    if db_data
      result = db_data.map { |x| self.new(x)}   # fails if none found
    return result
    else
    return []
    end

  end

  def self.all()
    sql = "SELECT * FROM #{self.get_table_from_class};"
    return self.get_many(sql)
  end

# # UPDATE METHODS

  def update()
    sql = "UPDATE #{self.class.get_table_from_class} SET 
            ( #{self.get_table_fields} )
             = ( #{self.get_values_list} )
             WHERE id = #{@id} ; "
    result = SqlRunner.run(sql)
    return 
  end


# # DELETE METHODS

  def self.delete_all()
    sql = "DELETE FROM #{self.get_table_from_class} ;"
    db_data = SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM #{self.class.get_table_from_class} WHERE id = #{@id} RETURNING * ;"
    return self.class.new(SqlRunner.run(sql).first)
  end

 # # Utility methods used by above

  def self.get_table_from_class()      # derive SQL tablename from Class name - assumes ruby "Class_type" => SQL "class_types" table
    return self.to_s.downcase + "s"
  end

  def get_table_fields()              # derive table column names from object instance variable names
    table_fields = ""
    variables = self.instance_variables      
    variables.each do |x| 
      table_fields += x.to_s.delete("@") + ", " unless instance_variable_get(x).class == Array
    end
    return table_fields.chop!.chop!   # strip trailing comma from string
  end

  def get_values_list()              # get values of object instance variables and single quote strings to pass to SQL
    variables = self.instance_variables     # instance_variables() returns array of symbols of form :@varname
    values_list = ""
    variables.each do |x|                   # want to single quote strings in SQL, not quote other types 
      if instance_variable_get(x).class == Array
          # skip - no @id to use yet
      elsif instance_variable_get(x).class == String
        values_list += "'" + instance_variable_get(x).to_s + "', "
      elsif instance_variable_get(x).class == Date
        values_list += "'" + instance_variable_get(x).to_s + "', "
      else
        values_list += instance_variable_get(x).to_s + ", "
      end
    end
    values_list.chop!.chop!         # strip trailing comma and space from assembled string
  end

  def arrays_to_save
    arrays = []
    variables = self.instance_variables
    variables.each do |x| 
      if instance_variable_get(x).class == Array
        arrays << instance_variable_get(x)
      end
    end
    return arrays
  end

  def save_array_1_to_many(array_x, parent)
    array_x.each do |element|
      # save each element into a table (arrayelement.class)s_for_(object.class)s
      # as a 1 to many relation
      table_name = element.class.to_s.downcase  + "s_for_" + parent.class.to_s.downcase + "s"
      sql = "INSERT INTO #{table_name} 
      ( #{element.class.to_s.downcase}_id, #{parent.class.to_s.downcase}_id ) 
      VALUES (#{element.id}, #{parent.id}) RETURNING * ;"
      db_data = SqlRunner.run(sql)
    end
  end
end