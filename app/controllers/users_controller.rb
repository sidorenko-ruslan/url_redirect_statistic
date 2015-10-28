class UsersController < ApplicationController
	def auth
		@user = User.new
	end

	def options

	end

	def check
		@user = User.find( login: params[:login], password: params[:password] )
	end
end
