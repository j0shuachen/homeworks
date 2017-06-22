# == Schema Information
#
# Table name: artworks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artwork < ApplicationRecord
  belongs_to :artist,
  primary_key: :id,
  foreign_key: :artist_id,
  class_name: :User

  has_many :shares,
  primary_key: :id,
  foreign_key: :artwork_id,
  class_name: :ArtworkShare

  has_many :viewers,
  primary_key: :id,
  foreign_key: :viewer_id,
  class_name: :User

  has_many :shared_viewers,
  through: :viewers,
  source::
end
