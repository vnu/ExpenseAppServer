# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  user_id      :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Category < ActiveRecord::Base
end
