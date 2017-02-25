require_relative('../models/burger.rb')
require('pry')

options1 = {
  'name' => "Big Kahuna with cheese",
  'price' => 999,
  'restaurant_id' => 1,
  'preference' => 3
}
@burger1 = Burger.new(options1)
@burger1.save



binding.pry
nil
