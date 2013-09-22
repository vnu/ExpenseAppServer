# == Schema Information
#
# Table name: sub_categories
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  category_id  :integer          not null
#  user_id      :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class SubCategory < ActiveRecord::Base
end
