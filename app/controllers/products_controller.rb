class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html, except: :show
  respond_to :json, except: :edit

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: ProductDatatable.new(view_context, {datatables: params[:draw]})
      end
    end
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    @product.save
    respond_with(@product, location: products_url)
  end

  def update
    @product.update(product_params)
    respond_with(@product, location: products_url)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  PRODUCT_PARAMS = %i(description endeca_id name price_max price_min price_retail product_type url year)

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(PRODUCT_PARAMS)
    end
end
