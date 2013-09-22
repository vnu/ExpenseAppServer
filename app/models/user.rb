# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  first_name        :string(255)
#  last_name         :string(255)      not null
#  email             :string(255)      not null
#  twitter_user_name :string(255)      not null
#  twitter_uid       :string(255)      not null
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  has_many :accounts
  validates_presence_of :email, :twitter_uid, :twitter_user_name, :last_name
end
