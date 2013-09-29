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
        t.transaction_type = t.find_transaction_type(params[:trans_type])
        t.user_id = user_id
        emails = params[:emails]
        if emails.present? && params[:trans_type].titleize == "Shared"
          users = find_users(emails)
          users << user_id
          t = create_shared_accounts(users, t)
        end
        t.save!
      else
        t = "Your Account doesn't exist. Please Create your Account!"
      end
    end
    t
  end

  # Add creation of Shared accounts to after save!
  def create_shared_accounts(users, t)
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



end
