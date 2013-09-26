# == Schema Information
#
# Table name: transaction_types
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

class TransactionType < ActiveRecord::Base
  has_many :transactions
end
