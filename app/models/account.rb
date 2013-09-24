# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  display_name :string(255)
#  balance      :decimal(10, 2)   default(0.0)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Account < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :display_name, :scope => [:user_id]
end
