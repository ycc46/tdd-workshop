require 'rails_helper'

RSpec.describe Placement, type: :model do
  before :each do
    @create_placement = build :placement
  end

  subject { @create_placement }

  it { should respond_to :order_id }
  it { should respond_to :toy_id }
  it { should be_valid }

  it { should validate_presence_of :order_id }
  it { should validate_presence_of :toy_id }

  it { should belong_to :toy }
  it { should belong_to :order }

end
