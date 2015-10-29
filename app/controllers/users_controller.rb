class UsersController < ApplicationController
	def auth
		@user = User.find_by_id(session[:user_id])
		if (@user)
			redirect_to :controller => 'statistics', :action => 'index'
		else
			@user = User.new
			session[:return_to] ||= request.referrer
		end
	end

	def options

	end

	def check
		p params
		@user = User.find_by_login_and_password( params[:user][:login], params[:user][:password] )
		if (@user)
			session[:user_id] =  @user.id
			redirect_to :controller => 'statistics', :action => 'index'
		else
			session[:return_to] ||= request.referrer
			redirect_to session.delete(:return_to)
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to :controller => 'users', :action => 'auth'
	end
end
