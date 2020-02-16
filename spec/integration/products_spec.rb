require 'swagger_helper'

describe 'Products API V1' do

  path '/api/v1/products' do

    get 'List all products' do
      tags 'Products'
      response '200', 'products found' do
        Product.create(name: 'Product Test 1', price: 10.0)
        Product.create(name: 'Product Test 2', price: 20.0)
        Product.create(name: 'Product Test 3', price: 30.0)
        run_test!
      end
    end

    post 'Creates a product' do
      tags 'Products'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Product Test 1' },
          price: {
            type: :number,
            format: :float,
            description: 'A positive number',
            example: 10.0
          }
        },
        required: ['name', 'price']
      }
      response '201', 'product created' do
        let(:product) { { name: 'Test Product 1', price: 10.0 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:product) { { name: 'Test Product 1', price: -10.0 } }
        run_test!
      end
    end
  end

  path '/api/v1/products/{id}' do
    get 'Retrieves a product' do
      tags 'Products'
      parameter name: :id, in: :path, schema: { type: :integer }
      response '200', 'product found' do
        schema type: :object,
          properties: {
          id: { type: :integer },
          name: { type: :string },
          price: { type: :number, format: :float },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: ['id', 'name', 'price', 'created_at', 'updated_at']

        let(:id) { Product.create(name: 'Product Test 1', price: 10.0).id }
        run_test!
      end
    end

    put 'Updates a product' do
      tags 'Products'
      parameter name: :id, in: :path, schema: { type: :integer }
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string, example: 'Product Updated Test 1' },
          price: {
            type: :number,
            format: :float,
            description: 'A positive number',
            example: 20.0
          }
        },
        required: []
      }

      response '200', 'product updated' do
        schema type: :object,
          properties: {
          id: { type: :integer },
          name: { type: :string },
          price: { type: :number, format: :float },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: ['id', 'name', 'price', 'created_at', 'updated_at']

        let(:id) { Product.create(name: 'Product Test 1', price: 10.0).id }
        let(:product) { { name: "Product Updated 1", price: 50.0 } }
        run_test!
      end
    end

    delete 'Deletes a product' do
      tags 'Products'
      parameter name: :id, in: :path, schema: { type: :integer }

      response '204', 'product deleted' do
        let(:id) { Product.create(name: 'Product Test 1', price: 10.0).id }
        run_test!
      end
    end
  end
end
