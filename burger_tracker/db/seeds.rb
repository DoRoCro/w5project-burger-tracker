require_relative('../models/address.rb')
require_relative('../models/restaurant.rb')
require_relative('../models/burger.rb')
require_relative('../models/deal.rb')
require('pry')

# Following setup assumes a clean database with serial numbers starting from 1

# Add address
options1 = {
  'street_addr' => '21',
  'street' => 'Lothian Road',
  'area' => '',
  'city' => 'Edinburgh',
  'post_code' => 'EH1 2AB',
  'telephone' => '+44 1234 567890'
}
options2 = {
  'street_addr' =>'22',
  'street' =>'Lothian Road',
  'area' =>'',
  'city' =>'Edinburgh',
  'post_code' =>'EH1 2AB',
  'telephone' => '+44 1234 567891'
}
address1 = Address.new(options1)
address2 = Address.new(options2)
address1.save
address2.save

# Add restaurants
options3 = {
  'name' => "Big Kahuna Burgers",
  'address_id' => address1.id
}
restaurant3 = Restaurant.new(options3)
restaurant3.save

options4 = {
  'name' => "Betta Burgers",
  'address_id' => address2.id
}
restaurant4 = Restaurant.new(options4)
restaurant4.save


options5 = {
  'name' => "Big Kahuna with cheese",
  'price' => 999,
  'restaurant_id' => restaurant3.id,
  'preference' => 4
}
options6 = {
  'name' => "Boring Ordinary",
  'price' => 799,
  'restaurant_id' => restaurant3.id,
  'preference' => 3
}

@burger5 = Burger.new(options5)
@burger6 = Burger.new(options6)
@burger5.save
@burger6.save

options7 = {
  'label' => "Big Opening 2 for 1",
  'burgers' => [@burger5, @burger6],
  'day' => "2017-03-02",
  'restaurant_id' => restaurant3.id,
  'discount' => 0.5,
  'money_off' => 0
}
deal7 = Deal.new(options7)
deal7.save


options = {
  'street_addr' =>'22',
  'street' =>'Lothian Road',
  'area' =>'',
  'city' =>'Edinburgh',
  'post_code' =>'EH1 2AB',
  'telephone' => '+44 1234 567891'
}
address = Address.new(options)
address.save

options = {
  'name' => "Even Betta Burgers",
  'address_id' => address.id
}
restaurant = Restaurant.new(options4)
restaurant.save

options = {
  'name' => "Bigger Betta Burger",
  'price' => 999,
  'restaurant_id' => restaurant.id,
  'preference' => 3
}

burger3 = Burger.new(options)
burger3.save

options = {
  'name' => "Micro Betta Burger",
  'price' => 499,
  'restaurant_id' => restaurant.id,
  'preference' => 3
}

burger4 = Burger.new(options)
burger4.save


options = {
  'label' => "Betta Thursdays",
  'burgers' => [burger3, burger4],
  'day' => "2017-03-02",
  'restaurant_id' => restaurant3.id,
  'discount' => 0,
  'money_off' => 200
}
deal = Deal.new(options)
