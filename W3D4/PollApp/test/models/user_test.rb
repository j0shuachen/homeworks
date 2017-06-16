# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_user_name  (user_name) UNIQUE
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
