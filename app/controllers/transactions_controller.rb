class TransactionsController < ApplicationController
  before_filter :require_authentication
  before_filter :require_email

  def new
  end

  def create
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id.present?
      transaction = Transaction.create_new_transaction(params, user_id)
      redirect_to new_transaction_path, notice: "transaction: #{transaction.inspect}"
    end
  end

  def index
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id
      @transactions = Transaction.where(user_id: user_id)
      respond_to do |format|
        format.html {}
        format.json {render json: Transaction.to_jsonFormat(@transactions)}
      end
    end
  end

  def show
    
  end
end
