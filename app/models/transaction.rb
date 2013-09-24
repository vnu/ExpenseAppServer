# == Schema Information
#
# Table name: transactions
#
#  id                  :integer          not null, primary key
#  vendor_id           :integer          not null
#  account_id          :integer          not null
#  category_id         :integer          not null
#  sub_category_id     :integer
#  payment_mode_id     :integer          not null
#  notes               :text
#  transaction_type_id :integer          not null
#  amount              :decimal(10, 2)
#  user_id             :integer          not null
#  created_at          :datetime
#  updated_at          :datetime
#

class Transaction < ActiveRecord::Base
end
