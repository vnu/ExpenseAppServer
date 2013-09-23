# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string(255)      not null
#  email             :string(255)      not null
#  twitter_user_name :string(255)      not null
#  twitter_uid       :string(255)      not null
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  has_many :accounts
  validates_presence_of :email, :twitter_uid, :twitter_user_name, :name

  def self.from_twitter_omniauth(auth)
    uid = auth['uid']
    user_name = auth["info"]["nickname"]
    where(twitter_uid: uid, twitter_user_name: user_name).first || create_new_user(auth)
  end

  def self.create_new_user(auth)
    create! do |user|
      user.twitter_uid = auth['uid']
      user.name = auth["info"]["name"]
      user.twitter_user_name = auth["info"]["nickname"]
      user.email = "test@example.com"
    end
  end
end
