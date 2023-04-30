class AuthenticationsController < ApplicationController
  def new
    @authentication = Authentication.new
  end

  def create
    @authentication = Authentication.new(authentication_params)
    if @authentication.valid?
      session[:current_user_id] = @authentication.user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path
  end

  private

  def authentication_params
    params.require(:authentication).permit(:email, :password)
  end
end
