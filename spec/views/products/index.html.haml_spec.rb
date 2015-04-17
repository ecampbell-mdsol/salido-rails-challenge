require 'rails_helper'

RSpec.describe 'products/index', type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        name: 'Name',
        product_type: 'Type',
        price_retail: '99.99',
        description: 'Description'
      ),
      Product.create!(
        name: 'Name',
        product_type: 'Type',
        price_retail: '99.99',
        description: 'Description'
      )
    ])
  end

  it 'renders a list of products' do
    render
    assert_select "tr>td", text: 'Name', count: 2
    assert_select "tr>td", text: 'Type', count: 2
    assert_select "tr>td", text: '$99.99', count: 2
    assert_select "tr>td", text: 'Description', count: 2
  end
end
