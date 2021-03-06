require_relative('../db/crud.rb')
class Address < Crud

  attr_reader   :id 
  attr_accessor :street_addr, :street, :area, :city, :post_code, :telephone
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @street_addr = options['street_addr']  || ""
    @street = options['street'] || ""
    @area = options['area'] || ""
    @city = options['city'] || ""
    @post_code = options['post_code'] || ""
    @telephone = options['telephone'] || ""
  end

  def set_id(id)
    # setter required for use in restaurant / address combination
    @id = id
  end
end