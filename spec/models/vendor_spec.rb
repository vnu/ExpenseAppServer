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

require 'spec_helper'

describe Vendor do
  pending "add some examples to (or delete) #{__FILE__}"
end
