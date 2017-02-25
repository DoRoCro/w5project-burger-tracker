require_relative('../db/crud.rb')
class Restaurant < Crud

  attr_reader :id, :name, :address_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @address_id = options['address_id']
  end

end