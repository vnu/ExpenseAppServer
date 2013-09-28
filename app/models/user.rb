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
  has_many :transactions
  has_many :shared_transactions, foreign_key: 'user_id', class_name: "SharedTransaction"
  has_many :owned_transactions, foreign_key: 'owner_id', class_name: "SharedTransaction"
  validates_presence_of :twitter_uid, :twitter_user_name, :name
  validates_uniqueness_of :email, :twitter_uid, :twitter_user_name

  def self.from_twitter_omniauth(auth)
    uid = auth['uid']
    user_name = auth["info"]["nickname"]
    where(twitter_uid: uid, twitter_user_name: user_name).first || create_new_user_from_auth(auth)
  end

  def self.create_new_user_from_auth(auth)
    create! do |user|
      user.twitter_uid = auth['uid']
      user.name = auth["info"]["name"].titleize
      user.twitter_user_name = auth["info"]["nickname"]
    end
  end

  def self.create_new_user(params)
    create! do |user|
      user.twitter_uid = params["uid"]
      user.name = params["name"].titleize
      user.twitter_user_name = params["username"]
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
