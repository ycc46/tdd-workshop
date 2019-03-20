class Placement < ApplicationRecord
  belongs_to :order, inverse_of: :placements
  belongs_to :toy, inverse_of: :placements

  after_create :update_inventory

  def update_inventory
    toy.update(quantity: toy.quantity - quantity)
  end
end
