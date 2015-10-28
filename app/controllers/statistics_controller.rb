class StatisticsController < ApplicationController
	def index
		@installations = Installation.all
	end

	def create
		installation = Installation.where( date: Date.today.to_s, source: params[:source] )
		if installation.blank?
			Installation.create( { date: Date.today.to_s, count: params[:count] } )
		else
			Installation.where( source: params[:source], date: Date.today.to_s).update_all( count: params[:count] )
		end
		render status: 200, text: "success"
	end
end
