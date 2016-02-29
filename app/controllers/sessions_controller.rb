class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env)
      session[:user_id] = user.id
      redirect to dashboard_path
    else
      redirect_to root_path
  end
end
