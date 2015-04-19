require 'rails_helper'

RSpec.describe 'products/index', type: :view do
  before do
    FactoryGirl.create(:product)
  end

  it 'renders a empty list of products' do
    render
    assert_select 'tbody>tr', count: 0
  end
end
