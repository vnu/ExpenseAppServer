class TransactionsController < ApplicationController
  before_filter :require_authentication, unless: :format_json
  before_filter :require_email, unless: :format_json

  def index
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id
      @transactions = Transaction.where(user_id: user_id).order("transaction_date")
      @jsonTransactions = Transaction.to_jsonFormat(@transactions)
      @jsonArr = {"transactions" => @jsonTransactions}
    end
    respond_to do |format|
      format.html {}
      format.json {render json: @jsonArr || "Sorry" }
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

  def overview
    user_id = get_user
    if user_id.present?
      expenses = Transaction.get_total_of("Expense", user_id)
      incomes = Transaction.get_total_of("Income", user_id)
      to_pay = SharedTransaction.where("user_id = :uid and owner_id <> :uid", uid: user_id).sum(:amount)
      to_be_paid = SharedTransaction.where("user_id <> :uid and owner_id = :uid", uid: user_id).sum(:amount)    
      shared = to_be_paid - to_pay
    end
    @overview = {expenses: expenses, incomes: incomes, to_pay: to_pay, to_be_paid: to_be_paid, shared: shared}
    respond_to do |format|
      format.html {}
      format.json {render json: @overview || "Sorry" }
    end    
  end

  def expenses
    user_id = get_user
    if user_id.present?
     @jsonTransactions = Transaction.getTransactionbyType(user_id, "Expense")
     @jsonArr = {"transactions" => @jsonTransactions}
    end
    respond_to do |format|
      format.html {}
      format.json {render json: @jsonArr || "Sorry" }
    end
  end

  def shared
    user_id = get_user
    if user_id.present?
     @jsonTransactions = Transaction.getTransactionbyType(user_id, "Shared")
     @jsonArr = {"transactions" => @jsonTransactions}
    end
    respond_to do |format|
      format.html {}
      format.json {render json: @jsonArr || "Sorry" }
    end
  end

  def incomes
    user_id = get_user
    if user_id.present?
     @jsonTransactions = Transaction.getTransactionbyType(user_id, "Income")
     @jsonArr = {"transactions" => @jsonTransactions}
    end
    respond_to do |format|
      format.html {}
      format.json {render json: @jsonArr || "Sorry" }
    end
  end

  def get_user
    session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
  end
end
