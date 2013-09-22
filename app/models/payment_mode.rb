# == Schema Information
#
# Table name: payment_modes
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  user_id      :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class PaymentMode < ActiveRecord::Base
end
