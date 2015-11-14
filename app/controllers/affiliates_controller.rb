class AffiliatesController < ApplicationController

	def index
		if is_auth?
			@affiliates = Affiliate.order(:name,:is_enabled)
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

	def show

	end

	def new
		if is_auth?
			@companies = Company.all
			@affiliate = Affiliate.new
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

	def create
		if is_auth?
			@affiliate = Affiliate.create(affiliate_params)
			if @affiliate.errors.empty?
				redirect_to :controller => "affiliates", :action => "index"
			else
				render "new"
			end
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

	def edit
		if is_auth?
			@companies = Company.all
			@affiliate = Affiliate.find(params[:id])
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

	def update 
		if is_auth?
			@affiliate = Affiliate.find(params[:id])
			@affiliate.update_attributes(affiliate_params)
			if @affiliate.errors.empty?
				redirect_to :controller => "affiliates", :action => "index"
			else
				render "edit"
			end
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

	def destroy
		if is_auth?
			@affiliate = Affiliate.find(params[:id])
			@affiliate.destroy
			redirect_to :controller => "affiliates", :action => "index"
		else
			redirect_to :controller => 'users', :action => 'auth'
		end
	end

private
	def affiliate_params
		params.require(:affiliate).permit(:name,:company_id,:is_enabled)
	end

end
