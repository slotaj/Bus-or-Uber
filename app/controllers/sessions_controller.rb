require 'net/http'
require 'json'
require 'uri'
class SessionsController < ApplicationController

  def create
    if user = User.from_omniauth(request.env)
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
