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

class User < ApplicationRecord
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Polls

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response
end
