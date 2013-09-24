class AccountsController < ApplicationController
  def create
    puts "Session #{session.inspect}"
    name = params["account_name"]
    balance = params["account_balance"]
    Account.find_or_create_by(display_name: name, user_id: current_user.id, balance: balance.to_f)
    redirect_to accounts_path
  end

  def index
    user_id = session[:user_id]
    @accounts = Account.where(user_id: user_id)
    respond_to do |format|
      format.html {}
      format.json {render json: @accounts}
    end
  end

  def new
  end

  def show
    
  end
end
