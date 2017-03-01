require('date')
require_relative('../db/crud.rb')
require_relative('./restaurant.rb')
class Deal < Crud
  
  attr_reader :id, :label, :burgers, :day, :restaurant_id, :discount, :money_off
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @label = options['label']
    @burgers = options['burgers']
    @day = Date.parse(options['day'])
    @restaurant_id = options['restaurant_id']
    @discount = options['discount'].to_f || 0.0
    @money_off = options['money_off'].to_i  || 0
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

  # some selected Date handling, in the deal file as this is the only Class making use of date/time
  def day_of_week
    # Date.wday returns 0-6 for Sunday,...Saturday
    return @day.wday
  end

  def self.deals_of_the_day(weekday)
    deals = Deal.all()
    deals.select! {|d| ( d.day_of_week  == weekday ) }
    return  deals
  end

  def self.int_to_weekday(wday_num)
    weekdays = ["Sunday",
       "Monday",
       "Tuesday", 
       "Wednesday", 
       "Thursday", 
       "Friday", 
       "Saturday"]
       return weekdays[wday_num]
  end

  def savings(price)
    return price.to_f * @discount + @money_off
  end

end
