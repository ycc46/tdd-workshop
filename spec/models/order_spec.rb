require 'rails_helper'

RSpec.describe Order, type: :model do
  before :each do
    @create_order = build :order
  end

  subject { @create_order }

  it { should respond_to :total }
  it { should respond_to :user_id }
  it { should be_valid }

  it { should validate_presence_of :total }
  it { should validate_presence_of :user_id }

  it { should belong_to :user }


end
