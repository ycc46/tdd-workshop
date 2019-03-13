require 'rails_helper'

RSpec.describe Order, type: :model do
  before :each do
    @create_order = build :order
  end

  subject { @create_order }


  it { should respond_to :total }
  it { should respond_to :user_id }
  it { should be_valid }

  it { should validate_presence_of :user_id }

  it { should belong_to :user }

  it { should have_many :placements }
  it { should have_many(:toys).through :placements }

  describe '#set_total!' do
    before :each do
      toy1 = create :toy, price: 100
      toy2 = create :toy, price: 85
      placement1 = create :placement, toy_id: toy1.id, quantity: 3
      placement2 = create :placement, toy_id: toy2.id, quantity: 4

      @create_order.placements << placement1
      @create_order.placements << placement2

    end

    it 'returns the total amount to pay for the toys' do
      expect{ @create_order.set_total! }.to change { @create_order.total }.from(0).to(640)
    end
  end

  describe '#build_placements' do
    before :each do
      toy1 =create :toy, price:100
      toy2 =create :toy, price:85

      @toy_ids_and_quantites = [[toy1.id, 2], [toy2.id, 3]]
    end
    it 'returns the total amount to pay for the toys' do
      expect(@create_order.build_placements(@toy_ids_and_quantites)).to be_present
    end
  end
end
