require 'rails_helper'

RSpec.describe Placement, type: :model do
  before :each do
    @create_placement = build :placement
  end

  subject { @create_placement }

  it { should respond_to :order_id }
  it { should respond_to :toy_id }

  it { should belong_to :order }
  it { should belong_to :toy }

  describe '#update_inventory' do
    before :each do
      @toy = build :toy, quantity: 10
      @placement = build :placement, toy: @toy, quantity: 3
    end
    it 'returns the update inventory' do
      expect { @placement.update_inventory }.to change { @toy.quantity }.from(10).to(7)
    end
  end
end
