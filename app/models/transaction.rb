# == Schema Information
#
# Table name: transactions
#
#  id                  :integer          not null, primary key
#  vendor_id           :integer          not null
#  account_id          :integer          not null
#  notes               :text
#  transaction_date    :datetime
#  transaction_type_id :integer          not null
#  amount              :decimal(10, 2)
#  user_id             :integer          not null
#  created_at          :datetime
#  updated_at          :datetime
#

class Transaction < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :account
  belongs_to :user
  belongs_to :transaction_type
  has_many :shared_transactions, autosave: true
  accepts_nested_attributes_for :shared_transactions
  after_save :update_account

  COLUMNS = ["id", "type", "vendor", "account", "amount", "user"]

  def self.create_new_transaction(params, user_id)
    t = "Unsuccessful"
      Transaction.transaction do
      t = Transaction.new
      t.amount = params[:amount].to_f
      t.vendor = t.find_or_create_vendor(params[:vendor], user_id)
      account = t.find_account(params[:account], user_id)
      if account.present?
        t.account = account
        t.transaction_date = params[:trans_date].to_date || Date.today
        t.notes = params[:notes]
        t.user_id = user_id
        emails = params[:emails]
        t_type = params[:trans_type].titleize
        if emails.present? && (t_type == "Shared" || t_type == "Expense")
          t_type = "Shared"
          users = find_users(emails)
          users << user_id
          t = create_shared_accounts(users, t, user_id)
        end
        t.transaction_type = t.find_transaction_type(t_type)
        t.save!
      else
        t = "Your Account doesn't exist. Please Create your Account!"
      end
    end
    t
  end

  # Add creation of Shared accounts to after save!
  def self.create_shared_accounts(users, t, user_id)
    cnt = users.count
    users.each do |u|
      t.shared_transactions.new do |s|
        u_vendor = t.find_or_create_vendor(t.vendor.display_name, u)
        s.vendor = u_vendor
        s.transaction_date = t.transaction_date
        s.notes = t.notes
        s.owner_id = user_id
        s.amount = t.amount/cnt.to_f
        s.user_id = u
      end
    end
    t
  end

  def update_account
    account = self.account
    type = self.transaction_type.display_name

    if type == "Income"
      account.balance = account.balance + self.amount
    else
      account.balance = account.balance - self.amount
    end
    account.save! if account.changed?
  end

  def find_transaction_type(type)
    TransactionType.find_by(display_name: type.titleize)
  end

  def self.get_total_of(type, user_id)
    type_id = TransactionType.find_by(display_name: type.titleize)
    total = if type == "Income"
      Transaction.where(transaction_type_id: type_id, user_id: user_id).sum(:amount)
    else
      Transaction.where(user_id: user_id).where.not(transaction_type_id: type_id).sum(:amount)
    end
    total
  end

  def find_account(account, user_id)
    Account.find_by(display_name: account.titleize, user_id: user_id)
  end

  def find_or_create_vendor(vendor, user_id)
    Vendor.find_or_create_by(display_name: vendor.titleize, 
      user_id: user_id)
  end

  def self.find_users(emails)
    users = []
    emails.split(",").each do |email|
      users << User.find_by(email: email.strip).try(:id)
    end
    users
  end

  def self.to_jsonFormat(transactions)
    new_trans = []
    transactions.each do |t|
      json_t = {
        id: t.id,
        type: t.transaction_type.display_name,
        amount: t.amount,
        vendor: t.vendor.display_name,
        account: t.account.display_name,
        user: t.user.twitter_user_name,
        notes: t.notes,
        trans_date: t.transaction_date
      }
      new_trans << json_t
    end
    new_trans
  end

  def self.getTransactionbyType(user_id, type)
    tid = TransactionType.find_by(display_name: "Income").try(:id)
    jsonTransactions = nil
    if(type == "Income")
      transactions = Transaction.where(transaction_type_id: tid, user_id: user_id).order("transaction_date desc") if tid
    else
      transactions = Transaction.where(user_id: user_id).where.not(transaction_type_id: tid).order("transaction_date desc") if tid if tid
    end
    if transactions.present?
      jsonTransactions = Transaction.to_jsonFormat(transactions)
    end
    jsonTransactions
  end

end
