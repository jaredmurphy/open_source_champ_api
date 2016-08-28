class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    api_user = ApiUser.find_by_provider_and_uid(auth["provider"], auth["uid"])
      || ApiUser.create_with_omniauth(auth)

    session[:api_user_id] = api_user.id
    redirect_to root_url, :notice => "Signed in!"

  end

  def destroy
    session[:api_user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
