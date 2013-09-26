class AccountsController < ApplicationController
  
  before_filter :require_authentication
  before_filter :require_email
  

  def create
    name = params["account_name"]
    balance = params["account_balance"]
    Account.find_or_create_by(display_name: name.titleize, user_id: current_user.id, balance: balance.to_f)
    redirect_to accounts_path
  end

  def index
    user_id = session[:user_id]
    @accounts = Account.where(user_id: user_id)
    @total = @accounts.sum :balance
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
