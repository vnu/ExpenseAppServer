class TransactionsController < ApplicationController
  before_filter :require_authentication, unless: :format_json
  before_filter :require_email, unless: :format_json

  def index
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id
      @transactions = Transaction.where(user_id: user_id)
      @jsonTransactions = Transaction.to_jsonFormat(@transactions)
    end
    respond_to do |format|
      format.html {}
      format.json {render json: @jsonTransactions || "Sorry" }
    end
  end
  
  def new
  end

  def create
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id.present?
      transaction = Transaction.create_new_transaction(params, user_id)
      if transaction.is_a?(String)
        notice = transaction
        redirect = new_account_path
      elsif transaction.is_a?(Transaction)
        notice = "Your Transaction added Successfully"
        redirect = transactions_path
      end
      respond_to do |format|
        format.html {redirect_to redirect, notice: notice}
        format.json {render json: notice}
      end
      
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
