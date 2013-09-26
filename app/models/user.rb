# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  email             :string(255)
#  twitter_user_name :string(255)      not null
#  twitter_uid       :string(255)      not null
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  has_many :accounts
  has_many :vendors
  has_many :accounts
  has_many :categories
  has_many :sub_categories
  has_many :payment_modes
  has_many :transactions
  has_many :shared_transactions
  validates_presence_of :twitter_uid, :twitter_user_name, :name
  validates_uniqueness_of :email

  def self.from_twitter_omniauth(auth)
    uid = auth['uid']
    user_name = auth["info"]["nickname"]
    where(twitter_uid: uid, twitter_user_name: user_name).first || create_new_user(auth)
  end

  def self.create_new_user(auth)
    create! do |user|
      user.twitter_uid = auth['uid']
      user.name = auth["info"]["name"].titleize
      user.twitter_user_name = auth["info"]["nickname"]
    end
  end

  def update_user(email, name=nil)
    success = false
    if email.present?
     self.email = email.downcase
     self.name = name if name.present?
     success = self.save! if self.changed?
   end
    success
  end
end
