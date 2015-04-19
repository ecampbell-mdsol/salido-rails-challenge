# coding: utf-8
Product.find_or_create_by!(
  name: 'Apple Corer',
  product_type: 'Accessory',
  price_retail: 0.99,
  description: 'It can core an apple!',
)
