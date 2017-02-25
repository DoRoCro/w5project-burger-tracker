class Deal < Crud
  
  attr_reader :id, :label, :applies_to, :day, :restaurant_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @label = options['label']
    @applies_to = options['applies_to']
    @day = options['day']
    @restaurant_id = options['restaurant_id']
  end

end