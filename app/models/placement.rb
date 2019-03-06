class Placement < ApplicationRecord
  validates :toy_id, :order_id, presence: true
  belongs_to :toy
  belongs_to :order
end
