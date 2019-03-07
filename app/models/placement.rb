class Placement < ApplicationRecord
  validates :toy_id, :order_id, presence: true
  belongs_to :toy
  belongs_to :order
  # belongs_to :toy, inverse_of: :placements
  # belongs_to :order, inverse_of: :placements
end
