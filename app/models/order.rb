class Order < ApplicationRecord
  before_validation :set_total!


  validates :user_id, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :user
  has_many :placements
  has_many :toys, through: :placements

  def set_total!
    placements.each do |placement|
      self.total += placement.toy.price * placement.quantity
    end
  end

  def build_placements(params = [])
    params.each do |(toy_id, qty)|
      self.placements.build toy_id: toy_id, quantity: qty
    end
  end
end
