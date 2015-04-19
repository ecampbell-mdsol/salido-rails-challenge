FactoryGirl.define do
  factory :product do
    description 'Fruity'
    endeca_id '123'
    name 'Red Wine'
    price_max '9.99'
    price_min '9.99'
    price_retail '9.99'
    product_type 'Wine'
    url 'http://www.example.com/red_wine.html'
    year '2015'
  end
end
