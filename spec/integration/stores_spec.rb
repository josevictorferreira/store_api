require 'swagger_helper'

describe 'Stores API V1' do

  path '/api/v1/stores' do

    get 'List all stores' do
      tags 'Stores'
      response '200', 'stores found' do
        Store.create(name: 'Store Test 1', address: 'Road Test 1')
        Store.create(name: 'Store Test 2', address: 'Road Test 2')
        Store.create(name: 'Store Test 3', address: 'Road Test 3')
        run_test!
      end
    end

    post 'Creates a store' do
      tags 'Stores'
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Store Test 1' },
          address: { type: :string, example: 'Road Test' }
        },
        required: ['name', 'address']
      }
      response '201', 'store created' do
        let(:store) { { name: 'Test Store 1', address: 'Road Test' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:store) { { name: 'Test Store 1', address: 'Ro' } }
        run_test!
      end
    end
  end

  path '/api/v1/stores/{id}' do
    get 'Retrieves a store' do
      tags 'Stores'
      parameter name: :id, in: :path, schema: { type: :integer }
      response '200', 'store found' do
        schema type: :object,
          properties: {
          id: { type: :integer },
          name: { type: :string },
          address: { type: :stirng },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: ['id', 'name', 'address', 'created_at', 'updated_at']

        let(:id) { Store.create(name: 'Store Test 1', address: 'Road Test').id }
        run_test!
      end
    end

    put 'Updates a store' do
      tags 'Stores'
      parameter name: :id, in: :path, schema: { type: :integer }
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Store Updated Test 1' },
          address: {
            type: :string,
            example: "Road Test"
          }
        },
        required: []
      }

      response '200', 'store updated' do
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          address: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: ['id', 'name', 'address', 'created_at', 'updated_at']

        let(:id) { Store.create(name: 'Store Test 1', address: 'Road Test').id }
        let(:store) { { name: "Store Updated 1", address: 'Road Test' } }
        run_test!
      end
    end

    delete 'Deletes a store' do
      tags 'Stores'
      parameter name: :id, in: :path, schema: { type: :integer }
      response '204', 'store deleted' do
        let(:id) { Store.create(name: 'Store Test 1', address: 'Road Test').id }
        run_test!
      end
    end
  end
end
