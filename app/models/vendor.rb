# == Schema Information
#
# Table name: vendors
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  user_id      :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Vendor < ActiveRecord::Base
  has_many :transactions
  has_many :shared_transactions
  belongs_to :user
  validates_uniqueness_of :display_name, :scope => [:user_id]
end
