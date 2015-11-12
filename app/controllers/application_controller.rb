class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  helper_method :is_auth?

  rescue_from CanCan::AccessDenied do |exception|
  	render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end

  def is_auth?
  	@user = User.find_by_id(session[:user_id])
    !@user.nil?
  end
  def current_user

  end
end
