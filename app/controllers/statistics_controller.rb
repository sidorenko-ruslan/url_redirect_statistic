class StatisticsController < ApplicationController
	authorize_resource class: false
	def index
		@user = User.find_by_id(session[:user_id])
		if (@user)
			@installations
			@statistics
			@header_title
			period = params[:query]
			if (period == "all" || period == nil)
				@header_title = "Amount"
				@installations = Installation.all
				@statistics = Statistic.order( date: :desc )
			elsif (period == "month")
				@header_title = "Last 30 days"
				@installations = Installation.where(created_at: 1.month.ago..Time.now)
				@statistics = Statistic.where(date: 1.month.ago..Time.now).order( date: :desc )
			end
			@translate_count = 0

			@statistics.each do |i|
				@translate_count += i[:count]
			end
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

	def create
		p params
		installation = Installation.find_by_device_id( params[:device_id] )
		if (installation.blank?)
			Installation.create( source: params[:source], device_id: params[:device_id] )
		end

		statistic = Statistic.find_by_date_and_source( Date.today.to_s, params[:source] )
		if (statistic.blank?)
			Statistic.create( { date: Date.today.to_s, count: params[:count], source: params[:source] } )
		else
			Statistic.where( source: params[:source], date: Date.today.to_s).update_all( count: params[:count] + statistic.count )
		end
		render status: 200, text: "success"
	end
end
