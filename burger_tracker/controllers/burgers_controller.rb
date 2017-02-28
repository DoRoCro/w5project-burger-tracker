require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/burger.rb' )

get '/burgers' do
  # show all burgers
  erb ( :"burgers/index" )
end
