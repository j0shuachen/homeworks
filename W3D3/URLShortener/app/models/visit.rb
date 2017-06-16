# == Schema Information
#
# Table name: visits
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  shortened_urls_id :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Visit < ApplicationRecord
  validates :user_id, :shortened_urls_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, shortened_urls_id: shortened_url.id)
  end

  belongs_to :user,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id
  #
  belongs_to :shortened_url,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :shortened_urls_id
  #
  # has_many :

end
