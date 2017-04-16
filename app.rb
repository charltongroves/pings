require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/pings'        #Model class
require 'date'


get '/' do
	erb :index
end

post '/:deviceID/:time' do
	@pings = Pings.new()
    @pings.device_ID = params[:deviceID].to_str
    @pings.time = params[:time].to_i

	if @pings.save
        status 200
	else
        status 400
		body "Sorry, there was an error!"
	end
end

get '/models' do
	@models = Model.all
	erb :models
end