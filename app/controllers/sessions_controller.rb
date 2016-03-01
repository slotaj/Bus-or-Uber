require 'net/http'
require 'json'
class SessionsController < ApplicationController

        #
        # curl -F 'client_secret=YOUR_CLIENT_SECRET' \
        #     -F 'client_id=YOUR_CLIENT_ID' \
        #     -F 'grant_type=authorization_code' \
        #     -F 'redirect_uri=YOUR_REDIRECT_URI' \
        #     -F 'code=AUTHORIZATION_CODE_FROM_STEP_2' \
        #     https://login.uber.com/oauth/v2/token

  def create

    auth_code = request.env["action_dispatch.request.parameters"]["code"]
    # connection = Faraday.new(url: 'https://login.uber.com/oauth/v2/token/') do |faraday|
    #       faraday.adapter  Faraday.default_adapter
    #       faraday.params[:client_secret] = ENV["uber_client_secret"]
    #       faraday.params[:client_id] = ENV["uber_client_id"]
    #       faraday.params[:grant_type] = 'authorization_code'
    #       faraday.params[:redirect_uri] = 'auth/uber/callback'
    #       faraday.params[:code] = auth_code
    #     end

      connection.post do |req|
      req.url "media/#{id}/comments"
      req.body = "text=#{comment}"
    end


    if user = User.from_omniauth(request.env)
      session[:user_id] = user.id
      redirect to dashboard_path
    else
      redirect_to root_path
    end
  end
end



# @connection = Faraday.new(url: 'https://api.instagram.com/v1/') do |faraday|
#       faraday.adapter  Faraday.default_adapter
#       faraday.params[:access_token] = user.token
#     end

# def create_comment(comment, id)
#     connection.post do |req|
#       req.url "media/#{id}/comments"
#       req.body = "text=#{comment}"
#     end
#   end
