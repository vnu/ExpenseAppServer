class SessionsController < ApplicationController
  def create
    user = User.from_twitter_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    if user.email.blank?
      redirect_to signup_path, notice: "Please complete your signup"
    else
      redirect_to root_url, notice: "Signed in!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url,notice: "Signed out!"
  end
end
