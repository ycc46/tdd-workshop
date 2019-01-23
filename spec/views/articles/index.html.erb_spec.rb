require 'rails_helper'

RSpec.describe "articles/index", type: :view do
  before(:each) do
    assign(:articles, [
      Article.create!(
        title: "Title"
      ),
      Article.create!(
        title: "Title"
      )
    ])
  end

  it "renders a list of articles" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
  end
end
