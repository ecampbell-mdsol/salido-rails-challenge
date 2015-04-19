class ProductDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari
  def_delegators :@view, :safe_join, :link_to, :content_tag, :edit_product_path

  def sortable_columns
    @sortable_columns ||= %w[Product.name Product.oid Product.product_type Product.price_retail]
  end

  def searchable_columns
    @searchable_columns ||= %w[Product.name Product.oid Product.product_type Product.price_retail]
  end

  private

  def data
    row_mapper =
      if options[:datatables]
        -> (product) do
          [markup_for_name(product), product.oid, product.product_type, '$%.2f' % product.price_retail]
        end
      else
        -> (product) { product.attributes }
      end
    records.map(&row_mapper)
  end

  def get_raw_records
    Product.all
  end

  def markup_for_name(product)
    safe_join(
      [
        link_to(edit_product_path(product)) do
          content_tag(:span, nil, class: 'glyphicon glyphicon-pencil')
        end,
        link_to(product, method: :delete, data: {confirm: 'Are you sure?'}) do
          content_tag(:span, nil, class: 'glyphicon glyphicon-remove')
        end,
        product.name
      ]
    )
  end
end
