# == Schema Information
#
# Table name: transactions
#
#  id                  :integer          not null, primary key
#  vendor_id           :integer          not null
#  account_id          :integer          not null
#  category_id         :integer
#  sub_category_id     :integer
#  payment_mode_id     :integer
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
  belongs_to :category
  belongs_to :sub_category
  belongs_to :payment_mode
  belongs_to :user
  belongs_to :transaction_type
  has_many :shared_transactions

  def self.create_new_transaction(params, user_id)
    t = Transaction.new
    t.amount = params[:amount].to_f
    t.vendor = t.find_or_create_vendor(params[:vendor], user_id)
    account = t.find_account(params[:account], user_id)
    if account.present?
      t.account = account
      t.transaction_date = params[:trans_date].to_date
      t.category = t.find_or_create_category(params[:category], user_id)
      if t.category.present?
        t.sub_category = t.find_or_create_subcategory(params[:sub_category],t.category, user_id)
      end
      t.payment_mode = t.find_or_create_payment_mode(params[:payment_mode], user_id)
      t.notes = params[:notes]
      t.transaction_type = t.find_transaction_type(params[:trans_type])
      t.user_id = user_id
      t.save!
      emails = params[:emails]
      if emails.present? && params[:trans_type].titleize == "Shared"
        users = find_users(emails)
        cnt = users.count
        users.each do |u|
          SharedTransaction.create! do |s|
            u_vendor = t.find_or_create_vendor(t.vendor.display_name, u)
            s.vendor = u_vendor
            s.transaction = t
            s.notes = t.notes
            s.owner = true if u == user_id
            s.amount = t.amount/cnt.to_f
            s.user_id = u
          end
        end
      end
    else
      t = nil
    end
    t
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

  def find_or_create_category(category, user_id)
    Category.find_or_create_by(display_name: category.titleize, 
      user_id: user_id)
  end

  def find_or_create_subcategory(subcategory, category, user_id)
    SubCategory.find_or_create_by(display_name: subcategory.titleize, 
      user_id: user_id, category: category)
  end

  def find_or_create_payment_mode(mode, user_id)
    PaymentMode.find_or_create_by(display_name: mode.titleize, 
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
        category: t.category.display_name,
        sub_category: t.sub_category.display_name,
        payment_mode: t.payment_mode.display_name,
        user: t.user.twitter_user_name
      }
      new_trans << json_t
    end
    new_trans
  end



end
