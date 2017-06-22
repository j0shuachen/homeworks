# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  age         :integer          not null
#  sex         :string(1)        not null
#  name        :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ApplicationRecord

  COLORS = ["Brown tabby", "Black", "Brown", "Seal point", "Blue point", "Cinnamon", "Marmalade"]
  validates :birth_date, presence: true
  validates :color, presence: true, inclusion: {in: COLORS, message: "Not a valid color"}
  validates :age, presence: true
  validates :sex, presence: true
  validates :name, presence: true
  validates :description, presence: true


  has_many :rental_requests, dependent: :destroy,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest
end
