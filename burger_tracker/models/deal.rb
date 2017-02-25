require('date')
require_relative('../db/crud.rb')
class Deal < Crud
  
  attr_reader :id, :label, :applies_to, :day, :restaurant_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @label = options['label']
    @applies_to = options['applies_to']
    @day = Date.parse(options['day'])
    @restaurant_id = options['restaurant_id']
  end

  def save()

  end

end
