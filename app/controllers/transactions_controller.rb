class TransactionsController < ApplicationController
  def show
    user_id = session[:user_id]
    @transactions = Transactions.where(user_id: user_id)
    respond_to do |format|
      format.html {}
      format.json {render json: @transactions}
    end
  end
end
