
# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("Pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date,  presence: true
  validates :status, presence: true, inclusion: { in: ["Pending", "Approved", "Denied"], message: "Invalid status"}
  validate :overlapping_requests

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat

  private
  def overlapping_requests
    approved_requests = CatRentalRequest.execute(<<-SQL, self.cat_id, self.id)
    SELECT
      cr.*
    FROM
      cat_rental_requests cr
    JOIN cats c ON cr.cat_id = c.id
    WHERE c.id = ? AND cr.id != ? AND cr.status = 'Approved'
    SQL
    unless approved_requests.exists?
      errors[:status] << "Already approved for a rental"
    end
  end

end
