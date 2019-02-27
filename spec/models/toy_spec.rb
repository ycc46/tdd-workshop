require 'rails_helper'

RSpec.describe Toy, type: :model do
  before :each do
    @toy = build :toy
  end

  subject { @toy }

  it { should respond_to :title }
  it { should respond_to :price }
  it { should respond_to :published }
  it { should respond_to :user_id }
  it { should be_valid }

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_presence_of :user_id }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

  it { should belong_to :user }

  describe '#filter_by_title to search toys match title keyword' do
    before :each do
      @toy1 = create :toy, title: 'Ruby1'
      @toy2 = create :toy, title: 'Ruby2'
      @toy3 = create :toy, title: 'Ruby3'
      @toy4 = create :toy, title: 'Ruby4'
    end

    it 'search toys with keyword' do
      expect(Toy.filter_by_title('Ruby')).to match_array([@toy1,@toy2,@toy3,@toy4])
    end
  end

  describe '#above_or_equal_to_price' do
    before :each do
      @toy1 = create :toy, price: 100
      @toy2 = create :toy, price: 200
      @toy3 = create :toy, price: 50
      @toy4 = create :toy, price: 300
    end

    it 'search toys above or equal to price' do
      expect(Toy.above_or_equal_to_price(100)).to match_array([@toy1,@toy2,@toy4])
    end

    it 'search toys below or equal to price' do
      #binding.pry
      expect(Toy.below_or_equal_to_price(100)).to match_array([@toy3,@toy1])
    end
  end

  describe '#recent_by_order_desc' do
    before :each do
      @toy1 = create :toy
      @toy2 = create :toy
      @toy3 = create :toy
      @toy4 = create :toy
    end

    it 'returns correct ordered toys' do
      expect(Toy.recent_by_order_desc).to eq [@toy4,@toy3,@toy2,@toy1]
    end
  end

  describe '#search' do
    before :each do
      @toy1 = create :toy, title: 'Ruby', price: 100
      @toy2 = create :toy, title: 'Ruby boy', price: 200
      @toy3 = create :toy, title: 'superman', price: 50
      @toy4 = create :toy, title: 'Java', price: 300
      @toy2.touch
    end

    it 'just have keyword and min_price and order' do
      params = { keyword: 'Ruby', min_price: 100, desc_order: true }
      expect(Toy.search(params)).to eq [@toy2,@toy1]
    end

    it 'just have keyword and max_price' do
      params = { keyword: 'Ruby', max_price: 100 }
      expect(Toy.search(params)).to match_array([@toy1])
    end

    it 'just have min_price and max_price' do
      params = { min_price: 100, max_price: 100}
      expect(Toy.search(params)).to match_array([@toy1])
    end

    it 'params is empty' do
      params = {}
      expect(Toy.search(params)).to match_array([@toy1,@toy2,@toy3,@toy4])
    end

  end

end
