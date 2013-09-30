class UsersController < ApplicationController
  def create
    if params[:username]
      user = User.find_by(twitter_user_name: params[:username])
      if user.present?
        if user.email.present?
          response = {auth: "signin"}
        elsif params[:email].present?
          success = user.update_user(params[:email], params[:name])
          response = {auth: "signin"}
        else
          response = {auth: "signup"}
        end
      else
        User.create_new_user(params)
        response = {auth: "signup"}
      end
    end
    respond_to do |format|
      format.json{render json: response}
    end
  end
end
