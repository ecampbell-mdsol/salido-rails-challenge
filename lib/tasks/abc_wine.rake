namespace :abc_wine do
  desc 'Loads all data from ABC WD API to Salito DB.'
  task load: :environment do
    BASE_URL = 'http://services.wine.com/api/beta2/service.svc/json/catalog'
    PAGE_SIZE = 100

    # "Discover" the number of pages to get.
    total = get_product_page(page_size: 1)['Total'].to_i
    number_of_pages = total / PAGE_SIZE + (total % PAGE_SIZE <=> 0)
    puts "#{number_of_pages} pages to process."
    created = 0

    number_of_pages.times do |page_number|
      print '.'
      get_product_page(page_number: page_number)['List'].each do |abc_product|
        unless Product.find_by(oid: abc_product['Id'])
          begin
            Product.create!(
              oid: abc_product['Id'],
              name: abc_product['Name'],
              description: abc_product['Description'],
              url: abc_product['Url'],
              price_min: abc_product['PriceMin'],
              price_max: abc_product['PriceMax'],
              price_retail: abc_product['PriceRetail'],
              product_type: abc_product['Type'],
              year: abc_product['Year'],
            )
            created += 1
          rescue StandardError => e
            puts 'ERROR'
            puts e
          end
        end
      end
    end

    puts "\n#{total} products processed.\n#{created} products created."
  end

  # Makes an API call to get a page of products.
  def get_product_page(page_number: 0, page_size: PAGE_SIZE)
    params = {apikey: ENV['wine_api_key'], offset: page_number * page_size, size: page_size}
    uri = URI.parse("#{BASE_URL}?#{params.to_param}")
    JSON.parse(Net::HTTP.get(uri))['Products']
  end
end
