require('minitest/autorun')
require('pry')
require_relative('../models/burger.rb')

class TestBurger < Minitest::Test

  def setup
    options1 = {
      'name' => "Big Kahuna with cheese",
      'price' => 999,
      'restaurant_id' => 1,
      'preference' => 3
    }
    @burger1 = Burger.new(options1)

  end

  def test_burger_has_params
    assert_equal(999, @burger1.price )
    assert_equal(1, @burger1.restaurant_id )
    assert_equal(3, @burger1.preference )
  end

  def test_can_do_currency_arithmetic
    # check currency arithmetic with BigDecimal type
    assert_equal(1998 , (@burger1.price * 2)  )
    assert_equal(499 , (@burger1.price) / 2 )
    assert_equal(99 , (@burger1.price % 900).to_f )
  end

  def test_has_id_after_save
    assert_equal(true,  @burger1.id == 0 )
    @burger1.save
    assert_equal(true,  @burger1.id != 0 )
  end

end