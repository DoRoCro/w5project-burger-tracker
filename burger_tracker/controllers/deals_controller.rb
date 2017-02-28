require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/deal.rb' )

get '/deals' do
  # show all deals
  erb( :"deals/index" )
end
