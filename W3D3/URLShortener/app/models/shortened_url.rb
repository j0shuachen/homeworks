# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class ShortenedUrl < ApplicationRecord
  include SecureRandom
  validates :short_url, :long_url, :user_id, presence: true



  def self.random_code
    rando_code = SecureRandom.urlsafe_base64[0..15]
    while ShortenedUrl.exists?(short_url: rando_code)
      rando_code = SecureRandom.urlsafe_base64[0..15]
    end
    rando_code
  end

  def self.create_short(user, long_url)
    x = self.random_code
    ShortenedUrl.create(long_url: long_url, user_id: user.id, short_url: x)
    # need exclamation after create?

  end

  belongs_to :submitter,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id

  has_many :visits,
    class_name: :Visit,
    foreign_key: :shortened_urls_id,
    primary_key: :id


  has_many :visitors,
    through: :visits,
    source: :user

  def num_clicks
    self.visitors.count
  end

  def num_uniqes
    visits.select(:user_id).distinct.length
  end

  # has_many :visitors,
  #   through: :visit


end
