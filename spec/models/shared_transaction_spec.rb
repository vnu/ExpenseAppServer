# == Schema Information
#
# Table name: shared_transactions
#
#  id               :integer          not null, primary key
#  vendor_id        :integer          not null
#  transaction_id   :integer          not null
#  notes            :text
#  owner_id         :integer          not null
#  transaction_date :datetime
#  amount           :decimal(10, 2)
#  user_id          :integer          not null
#  status           :string(255)      default("open")
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe SharedTransaction do
  pending "add some examples to (or delete) #{__FILE__}"
end
