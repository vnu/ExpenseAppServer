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

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
