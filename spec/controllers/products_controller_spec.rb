require 'rails_helper'

ActiveSupport.use_standard_json_time_format = false

RSpec.describe ProductsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {'name' => 'Red Wine', 'product_type' => 'Wine', 'price_retail' => '10', 'description' => 'House Wine'}
  end

  let(:invalid_attributes) do
    {'name' => '', 'product_type' => 'Wine', 'price_retail' => '10', 'description' => 'House Wine'}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe '#index' do
    before do
      FactoryGirl.create(:product, name: 'White Wine')
      FactoryGirl.create(:product, name: 'Pink Wine')
    end

    context 'when request format is JSON' do
      it 'returns a JSON representation the total and filtered number of products' do
        get :index, {search: {value: 'Pink'}, format: 'json'}, valid_session
        response_body = JSON.parse(response.body)
        expect(response_body.values_at('recordsTotal', 'recordsFiltered')).to eq([2, 1])
        expect(response_body['data']).to be_instance_of(Array)
        expect(response_body['data'].size).to eq(1)
        expect(response_body['data'].first).to be_instance_of(Hash)
      end
    end

    context 'when datatables outupt is requested' do
      it 'returns an array of arrays' do
        get :index, {draw: 0, format: 'json'}, valid_session
        response_body = JSON.parse(response.body)
        expect(response_body.values_at('recordsTotal', 'recordsFiltered')).to eq([2, 2])
        expect(response_body['data']).to be_instance_of(Array)
        expect(response_body['data'].size).to eq(2)
        expect(response_body['data'].first).to be_instance_of(Array)
        expect(response_body['data'].last).to be_instance_of(Array)
      end
    end
  end

  describe '#show' do
    it 'assigns the requested product as @product' do
      product = FactoryGirl.create(:product)
      get :show, {id: product.to_param, format: 'json'}, valid_session
      expect(assigns(:product)).to eq(product)
    end

    it 'responds with a JSON of the requested product' do
      product = FactoryGirl.create(:product)
      get :show, {id: product.id, format: 'json'}, valid_session
      expect(response.body).to eq(product.attributes.to_json)
    end
  end

  describe '#new' do
    it 'assigns a new product as @product' do
      get :new, {}, valid_session
      expect(assigns(:product)).to be_a_new(Product)
    end

    it 'returns the schema of a Product' do
      get :new, {format: 'json'}, valid_session
      expect(JSON.parse(response.body)).to eq(Hash[Product.attribute_names.zip([nil])])
    end
  end

  describe '#edit' do
    it 'assigns the requested product as @product' do
      product = Product.create! valid_attributes
      get :edit, {:id => product.to_param}, valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates a new Product' do
        expect { post :create, {:product => valid_attributes}, valid_session }.to change(Product, :count).by(1)
      end

      it 'assigns a newly created product as @product' do
        post :create, {:product => valid_attributes}, valid_session
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it 'redirects to the products list' do
        post :create, {:product => valid_attributes}, valid_session
        expect(response).to redirect_to(products_path)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved product as @product' do
        post :create, {product: invalid_attributes}, valid_session
        expect(assigns(:product)).to be_a_new(Product)
      end

      it 're-renders the `new` template' do
        post :create, {product: invalid_attributes}, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      let(:new_attributes) do
        {url: 'http://www.example.com'}
      end

      it 'updates the requested product' do
        product = Product.create! valid_attributes
        put :update, {id: product.to_param, product: new_attributes}, valid_session
        product.reload
        expected_result = valid_attributes.merge(new_attributes).stringify_keys
        expect(product.attributes.slice(*expected_result.keys)).to eq(expected_result)
      end

      it 'assigns the requested product as @product' do
        product = Product.create! valid_attributes
        put :update, {id: product.to_param, product: valid_attributes}, valid_session
        expect(assigns(:product)).to eq(product)
      end

      it 'redirects to the products list' do
        product = Product.create! valid_attributes
        put :update, {id: product.to_param, product: valid_attributes}, valid_session
        expect(response).to redirect_to(products_path)
      end
    end

    context 'with invalid params' do
      it 'assigns the product as @product' do
        product = Product.create! valid_attributes
        put :update, {id: product.to_param, product: invalid_attributes}, valid_session
        expect(assigns(:product)).to eq(product)
      end

      it 're-renders the `edit` template' do
        product = Product.create! valid_attributes
        put :update, {id: product.to_param, product: invalid_attributes}, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested product' do
      product = Product.create! valid_attributes
      expect { delete :destroy, {id: product.to_param}, valid_session}.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      product = Product.create! valid_attributes
      delete :destroy, {id: product.to_param}, valid_session
      expect(response).to redirect_to(products_url)
    end
  end

end
