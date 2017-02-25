require('minitest/autorun')
require('pry')
require_relative('../models/burger.rb')
require_relative('../models/restaurant.rb')
require_relative('../models/address.rb')
require_relative('../models/deal.rb')

class TestDeal < Minitest::Test

  def setup
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
    @burger1.save
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
      'applies_to' => [@burger1, @burger2],
      'day' => "2017-03-02",
      'restaurant_id' => @restaurant3.id,      # may be redundant info as inherited from burgers
      'discount' => 0.5
    }
    @deal1 = Deal.new(options6)

    end

    def test_deal_has_params
      
      assert_equal('Big Opening 2 for 1', @deal1.label )
      assert_equal(@restaurant3.id, @deal1.restaurant_id )
    end
end

