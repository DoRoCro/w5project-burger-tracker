require_relative('./burger_test.rb')
require_relative('../models/deal.rb')



options5 = {
  'name' => "Boring Ordinary",
  'price' => 799,
  'restaurant_id' => @restaurant3.id,
  'preference' => 2
}
@burger2 = Burger.new(options5)
@burger2.save

options6 = {
  'label' => "Big Opening 2 for 1",
  'burgers' => [@burger1, @burger2],
  'day' => "2017-03-02",
  'restaurant_id' => @restaurant3.id,      # may be redundant info as inherited from burgers
  'discount' => 0.5
}
@deal1 = Deal.new(options6)

@deal1.save

# check update functionality
@deal1.set_discount(0.4)
@deal1.update

# now break it by updating burgers array
@deal1.set_burgers([@burger1])
@deal1.update

# test find_by_id and update on address
address3 = Address.find_by_id(@address2.id)

address3.street_addr = "44"
address3.street = "High Street"
address3.city = "Biggar"
address3.post_code = "EH21 7AS"
address3.telephone = "+44 1968 123456"
binding.pry
address3.update


puts "passed restaurant address check"  if @address1.post_code == Restaurant.find_by_id(@restaurant3.id).address.post_code
# can't check objects are == because they are different object with the same content


nil

