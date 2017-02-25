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
      VALUES (#{self.get_values_list}) RETURNING * ;"
    db_data = SqlRunner.run(sql)
    @id = db_data.first['id'].to_i
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
      table_fields += x.to_s.delete("@") + ", " 
    end
    return table_fields.chop!.chop!   # strip trailing comma from string
  end

  def get_values_list()              # get values of object instance variables and single quote strings to pass to SQL
    variables = self.instance_variables     # instance_variables() returns array of symbols of form :@varname
    values_list = ""
    variables.each do |x|                   # want to single quote strings in SQL, not quote other types 
      if instance_variable_get(x).class == String
        values_list += "'" + instance_variable_get(x).to_s + "', "
      else
        values_list += instance_variable_get(x).to_s + ", "
      end
    end
    values_list.chop!.chop!         # strip trailing comma and space from assembled string
  end
end