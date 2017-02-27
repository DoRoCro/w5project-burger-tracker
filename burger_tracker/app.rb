require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/restaurants_controller')
# require_relative('controllers/deals_controller')
# require_relative('controllers/calendar_controller')

set :port, 4568
get '/' do
  erb( :index )
end