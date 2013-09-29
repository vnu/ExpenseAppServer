class SharedTransactionsController < ApplicationController

  before_filter :require_authentication, unless: :format_json
  before_filter :require_email, unless: :format_json

  def index
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id
      @transactions = SharedTransaction.where("user_id = ? OR owner_id = ?",user_id, user_id)
      @jsonTransactions = SharedTransaction.to_jsonFormat(@transactions, user_id)
      respond_to do |format|
        format.html {}
        format.json {render json: @jsonTransactions}
      end
    end
  end

  def to_pay
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id.present?
     @transactions = SharedTransaction.where("user_id = :uid and owner_id <> :uid", uid: user_id)
     @jsonTransactions = SharedTransaction.to_jsonFormat(@transactions, user_id)
     @jsonArr = {"transactions" => @jsonTransactions}
    end
    respond_to do |format|
      format.html {}
      format.json {render json: @jsonArr || "Sorry" }
    end
  end

  def to_be_paid
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id.present?
     @transactions = SharedTransaction.where("user_id <> :uid and owner_id = :uid", uid: user_id)
     @jsonTransactions = SharedTransaction.to_jsonFormat(@transactions, user_id)
     @jsonArr = {"transactions" => @jsonTransactions}
    end
    respond_to do |format|
      format.html {}
      format.json {render json: @jsonArr || "Sorry" }
    end
  end

  def shared
    user_id = session[:user_id] || User.find_by(twitter_user_name: params[:username]).try(:id)
    if user_id.present?
     @transactions = SharedTransaction.where("user_id = :uid or owner_id =:uid",uid: user_id)
     @jsonTransactions = SharedTransaction.to_jsonFormat(@transactions, user_id)
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
