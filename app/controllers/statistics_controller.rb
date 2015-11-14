class StatisticsController < ApplicationController
	authorize_resource class: false
	
	def index
		if is_auth?
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
		affiliate = Affiliate.find_by_name(params[:affiliate_name])
		if (affiliate.blank?)
			render status: 200, text: "fail"
		end

		installation = Installation.find_by_device_id( params[:device_id] )
		if (installation.blank?)
			Installation.create( affiliate_id: affiliate.id, device_id: params[:device_id] )
		end

		statistic = Statistic.find_by_date_and_affiliate_id( Date.today.to_s, affiliate.id )
		if (statistic.blank?)
			Statistic.create( { date: Date.today.to_s, count: params[:count], affiliate_id: affiliate.id } )
		else
			Statistic.where( affiliate_id: affiliate.id, date: Date.today.to_s).update_all( count: params[:count].to_i + statistic.count )
		end
		render status: 200, text: "success"
	end

	def get_data
		receive_company = params[:company]
		p receive_company
		if (!receive_company.blank?)
			company = Company.find_by_name(receive_company)
			p company
			json_reply = company.affiliates.to_json( :only => [:name,:is_enabled])
			json_reply = "{\"affiliates\":" + json_reply + "}"
			render status: 200, json: json_reply
		else
			render status: 200, text: "no data"
		end

	end
end
