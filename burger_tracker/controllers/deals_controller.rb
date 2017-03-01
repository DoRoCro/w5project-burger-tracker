require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/deal.rb' )

get '/deals' do
  # show all deals
  erb( :"deals/index" )
end

get '/deals/day_of_week/:id' do
  # List deals for day
  @deals = Deal.deals_of_the_day(params[:id].to_i)
  erb(:"deals/of_the_day")
end

get '/deals/today' do
  today = Time.now().wday
  redirect to "/deals/day_of_week/#{today}"
end