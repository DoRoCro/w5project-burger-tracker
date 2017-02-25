require_relative('../models/burger.rb')
require_relative('../models/restaurant.rb')
require_relative('../models/address.rb')
require('pry')


  options1 = {
    'street_addr' => '21',
    'street' => 'Lothian Road',
    'area' => '',
    'city' => 'Edinburgh',
    'post_code' => 'EH1 2AB',
    'telephone' => '+44 1234 567890'
  }
  @address1= Address.new(options1)
  options2 = {
    'street_addr' =>'22',
    'street' =>'Lothian Road',
    'area' =>'',
    'city' =>'Edinburgh',
    'post_code' =>'EH1 2AB',
    'telephone' => '+44 1234 567891'
  }
  @address2 = Address.new(options2)
  @address1.save
  @address2.save
  options3 = {
    'name' => "Big Kahuna",
    'address_id' =>  @address1.id
  }
  @restaurant3 = Restaurant.new(options3)
  @restaurant3.save
  options4 = {
    'name' => "Big Kahuna with cheese",
    'price' => 999,
    'restaurant_id' => @restaurant3.id,
    'preference' => 3
  }

  @burger1 = Burger.new(options4)

@burger1 = Burger.new(options4)
binding.pry
@burger1.save
