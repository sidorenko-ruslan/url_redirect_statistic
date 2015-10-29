class StatisticsController < ApplicationController
	authorize_resource class: false
	def index
		@user = User.find_by_id(session[:user_id])
		if (@user)
			@installations = Installation.all
			@statistics = Statistic.all
			@translate_count = 0

			@statistics.each do |i|
				@translate_count += i[:count]
			end
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

	def create
		installation = Installation.find_by_device_id( params[:device_id] )
		if (installation.blank?)
			Installation.create( source: params[:source], device_id: params[:device_id] )
		end

		statistic = Statistic.find_by_date_and_source( Date.today.to_s, params[:source] )
		if (statistic.blank?)
			Statistic.create( { date: Date.today.to_s, count: params[:count] } )
		else
			Statistic.where( source: params[:source], date: Date.today.to_s).update_all( count: params[:count] )
		end
		render status: 200, text: "success"
	end
end
