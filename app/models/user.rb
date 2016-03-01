class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    # byebug
    user = User.find_or_create_by(uid: auth['omniauth.auth'][:uid])
    user.uid           = auth['omniauth.auth'][:uid]
    user.email         = auth['omniauth.auth']['info']['email']
    user.first_name    = auth['omniauth.auth']['info']['first_name']
    user.last_name     = auth['omniauth.auth']['info']['last_name']
    user.image_url     = auth['omniauth.auth']['info']['picture']
    user.token         = auth['omniauth.auth']['credentials']['token']
    user.refresh_token = auth['omniauth.auth']['credentials']['refresh_token']
    user.save
    user
  end
end
