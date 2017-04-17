require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/pings'        #Model class
require 'date'

helpers do
	#if iso date, convert to posix at 12am that day
	def iso_to_posix(iso)
		Integer(iso) rescue DateTime.strptime(iso, '%Y-%m-%d').to_i
	end
	#If iso date, convert to posix at 12am the next day
	def iso_to_posix_exclusive(iso)
		Integer(iso) rescue (DateTime.strptime(iso, '%Y-%m-%d')+1).to_i
	end
	#Collate a list of device_id/ping hashes to a hash of device_id to list of pings
	def collate_pings(list_obj)
		collated_pings = {}
		list_obj.each do |element|
			device_id = element["device_ID"]
			if collated_pings[device_id] == nil
				collated_pings.store(device_id,[element["time"]])
			else
				collated_pings[device_id] << element["time"]
			end
		end
		return collated_pings
	end
end

post '/clear_data' do
	Pings.delete_all
	status = 200
end

post '/:deviceID/:time' do
	@pings = Pings.new()
    @pings.device_ID = params[:deviceID].to_str
    @pings.time = params[:time].to_i
	if @pings.save
        status 200
	else
        status 400
		body "Error adding ping to db!"
	end
end

get '/devices' do
	Pings.select(:device_ID).distinct.pluck(:device_ID).to_json
end

get '/all/:date' do
	from =  iso_to_posix(params[:date])
	to = iso_to_posix_exclusive(params[:date])
	pings = collate_pings(Pings.where('time >= '+from.to_s).where('time < '+to.to_s))
	pings.to_json
end

get '/all/:from/:to' do
	from =  iso_to_posix(params[:from])
	to =  iso_to_posix_exclusive(params[:to])
	pings = collate_pings(Pings.where('time >= '+from.to_s).where('time < '+to.to_s))
	pings.to_json
end

get '/:deviceID/:date' do
	from =  iso_to_posix(params[:date])
	to = iso_to_posix_exclusive(params[:date])
	Pings.where(device_ID: params[:deviceID]).where('time >= '+from.to_s).where('time < '+to.to_s).pluck(:time).to_json
end

get '/:deviceID/:from/:to' do
	from =  iso_to_posix(params[:from])
	to =  iso_to_posix_exclusive(params[:to])
	Pings.where(device_ID: params[:deviceID]).where('time >= '+from.to_s).where('time < '+to.to_s).pluck(:time).to_json
end

