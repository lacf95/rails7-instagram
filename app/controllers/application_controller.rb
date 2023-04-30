class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  protected

  def validates_user_session
    redirect_to new_authentication_path unless current_user
  end
end
