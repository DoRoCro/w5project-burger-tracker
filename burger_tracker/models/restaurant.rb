require_relative('../db/crud.rb')
class Restaurant < Crud

  attr_reader :id, :name, :address_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @address_id = options['address_id']
  end

  def address
    return Address.find_by_id(self.address_id)
  end

  def burgers
    sql = "SELECT * from #{ __method__ } WHERE restaurant_id = #{@id}"
    return Burger.get_many(sql)
  end
end