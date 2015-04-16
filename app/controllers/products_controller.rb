class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html, except: :show

  def index
    @products = Product.all
    respond_with(@products)
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
    @product.save!
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

  PERMITTED_ATTRIBUTES = %i(description name oid price_max price_min price_retail product_type url year)

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(*PERMITTED_ATTRIBUTES)
    end
end
