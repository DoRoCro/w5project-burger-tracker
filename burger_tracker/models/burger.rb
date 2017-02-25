require_relative('../db/crud.rb')
class Burger < Crud

  attr_reader :id, :name, :price, :restaurant_id, :preference

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @price = options['price'].to_i   # price in pence
    @restaurant_id = options['restaurant_id'].to_i
    @preference = options['preference'].to_i
  end

end