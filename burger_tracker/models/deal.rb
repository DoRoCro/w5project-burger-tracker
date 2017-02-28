require('date')
require_relative('../db/crud.rb')
require_relative('./restaurant.rb')
class Deal < Crud
  
  attr_reader :id, :label, :burgers, :day, :restaurant_id, :discount
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @label = options['label']
    @burgers = options['burgers']
    @day = Date.parse(options['day'])
    @restaurant_id = options['restaurant_id']
    @discount = options['discount']
  end


  def set_discount(discount)
    @discount = discount
  end

  def set_burgers(burger_list)
    @burgers = burger_list
  end

  def burgers
    sql = "SELECT b.* from #{ __method__ } b 
          INNER JOIN burgers_for_deals bfd ON bfd.burger_id = b.id
          WHERE deal_id = #{@id}"
    return Burger.get_many(sql)
  end

  def restaurant
    return Restaurant.find_by_id(@restaurant_id)
  end
  
end
