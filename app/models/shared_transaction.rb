# == Schema Information
#
# Table name: shared_transactions
#
#  id             :integer          not null, primary key
#  vendor_id      :integer          not null
#  transaction_id :integer          not null
#  notes          :text
#  owner          :boolean          default(FALSE)
#  amount         :decimal(10, 2)
#  user_id        :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

class SharedTransaction < ActiveRecord::Base
  belongs_to :transaction
  belongs_to :vendor
end
