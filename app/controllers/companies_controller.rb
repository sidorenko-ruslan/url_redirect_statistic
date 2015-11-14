class CompaniesController < ApplicationController

	def index
		if is_auth?
			@companies = Company.all
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

	def show

	end

	def new

	end

	def edit

	end

	def create

	end

	def destroy

	end

end
