require_relative('../db/crud.rb')
require_relative('./address.rb')
require_relative('./burger.rb')
require_relative('./deal.rb')
class Restaurant < Crud

  attr_reader :id, :name
  attr_accessor :address_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @address_id = options['address_id']
  end

  def address()
    return Address.find_by_id(self.address_id)
  end

  def burgers
    sql = "SELECT * from burgers WHERE restaurant_id = #{@id}"
    return Burger.get_many(sql)
  end

  def deals
    sql = "SELECT * from deals WHERE restaurant_id = #{@id}"    # might DRY this sometime
    return Deal.get_many(sql)
  end

end