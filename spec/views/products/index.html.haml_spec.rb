require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :name => "Name",
        :product_type => "Type",
        :price_retail => "Price Retail",
        :description => "Description"
      ),
      Product.create!(
        :name => "Name",
        :product_type => "Type",
        :price_retail => "Price Retail",
        :description => "Description"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Price Retail".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
