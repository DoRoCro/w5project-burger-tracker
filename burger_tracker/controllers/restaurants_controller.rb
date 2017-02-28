require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/restaurant.rb' )

get '/restaurants' do
  # show all restaurants
  erb ( :"restaurants/index" )
end

get '/restaurants/new' do
  # show form to add a new restaurant
  erb ( :"restaurants/new" )
end

post '/restaurants' do  
  # do an update with form data
  # need to create both a new restaurant AND address entry using the returned list of parameters.
  restaurant = Restaurant.new(params)
  address = Address.new(params)
  address.save()
  restaurant.address_id = address.id
  restaurant.save()
  redirect to "/restaurants"
end

get '/restaurants/:id' do
  # show individual restaurant
  # with options to edit, delete
  @restaurant = Restaurant.find_by_id(params[:id])
  erb ( :"restaurants/details" )
end

get '/restaurants/:id/edit' do
  # edit form for update restaurant details
  @restaurant = Restaurant.find_by_id(params[:id])
  erb ( :"restaurants/edit" )
end

post '/restaurants/:id/addresses/:address_id'  do
  # update from restaurant edit form, restaurant and address to update
  restaurant = Restaurant.new(params)
  address = Address.new(params)
  # correct id value for address which will be set to restaurant id as the POSTed 'id'
  address.set_id(params[:address_id])   
  address.update
  restaurant.update
  redirect to "restaurants/#{restaurant.id}"
end

get '/restaurants/:restaurant_id/burgers/new' do
  # edit form for new burger for given restaurant
  @restaurant = Restaurant.find_by_id(params[:restaurant_id])
  erb ( :"restaurants/burgers/new" )
end

post '/restaurants/:restaurant_id/burgers' do
  burger = Burger.new(params)
  burger.save
  # edit form for new burger for given restaurant
  redirect to "/restaurants/#{burger.restaurant.id}"
end

get '/restaurants/:restaurant_id/burgers/:burger_id/edit' do
  # edit form for burger for given restaurant
  @burger = Burger.find_by_id(params[:burger_id])
  erb ( :"restaurants/burgers/edit" )
end

post '/restaurants/:restaurant_id/burgers/:burger_id' do
  # edit form for burger for given restaurant
  params['id'] = params[:burger_id]
  burger = Burger.new(params)
  burger.update
  redirect to "/restaurants/#{burger.restaurant_id}" 
end

get '/restaurants/:restaurant_id/deals' do
  # list deals for restaurant
  @restaurant = Restaurant.find_by_id(params[:restaurant_id])
  erb ( :"restaurants/deals/index" )
end

get '/restaurants/:restaurant_id/deals/new' do
  # form to add new deal for restaurant
  erb ( :"restaurants/deals/new" )
end