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
end


get '/restaurants/:id' do
  # show individual restaurant
  # with options to edit, delete
end

get '/restaurants/:id/new' do
  # edit form for update
end
