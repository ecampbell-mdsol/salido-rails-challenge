require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :name => "MyString",
      :type => "",
      :price_retail => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_type[name=?]", "product[type]"

      assert_select "input#product_price_retail[name=?]", "product[price_retail]"

      assert_select "input#product_description[name=?]", "product[description]"
    end
  end
end