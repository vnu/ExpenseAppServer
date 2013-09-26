class WelcomeController < ApplicationController
  def index
  end

  def signup
  end

  def complete_signup
    email = params[:email]
    name = params[:name]
    success = current_user.update_user(email, name)
    url = signup_path
    notice = "Please complete your signup with proper info"
    if success
      url = root_path
      notice = "Sign up successful"
    end
    respond_to do |format|
      format.html {redirect_to url, notice: notice}
      format.json {
        render json: {signup: success}
      }
    end
    
  end
end
