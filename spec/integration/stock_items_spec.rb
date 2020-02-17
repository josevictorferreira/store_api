require 'swagger_helper'

describe 'Stock Items API V1' do

  path '/api/v1/stock_items' do

    get 'List all stock_items' do
      tags 'Stock Items'
      response '200', 'stock items found' do
        prod1 = Product.create(name: 'Product Test 1', price: 10.0)
        prod2 = Product.create(name: 'Product Test 2', price: 20.0)
        prod3 = Product.create(name: 'Product Test 3', price: 30.0)
        store = Store.create(name: 'Store Test', address: 'Store First')
        StockItem.create(product: prod1, store: store, items: 5)
        StockItem.create(product: prod2, store: store, items: 10)
        StockItem.create(product: prod3, store: store, items: 0)
        run_test!
      end
    end

    post 'Creates a stock item' do
      tags 'Stock Items'
      parameter name: :stock_item, in: :body, schema: {
        type: :object,
        properties: {
          product_id: { type: :integer, example: 1 },
          store_id: { type: :integer, example: 1 },
          items: { type: :integer, example: 5, default: 0 }
        },
        required: ['product_id', 'store_id']
      }
      response '201', 'stock item created' do
        prod = Product.create(name: 'Product Test 1', price: 10.0)
        store = Store.create(name: 'Store Test', address: 'Store First')
        let(:stock_item) { { product_id: prod.id, store_id: store.id, items: 5 } }
        run_test!
      end

      response '422', 'invalid request' do
        prod = Product.create(name: 'Product Test 1', price: 10.0)
        let(:stock_item) { { product_id: prod.id, items: 10.0 } }
        run_test!
      end
    end
  end

  path '/api/v1/stock_items/{id}' do
    get 'Retrieves a stock item' do
      tags 'Stock Items'
      parameter name: :id, in: :path, schema: { type: :integer }
      response '200', 'stock item found' do
        schema type: :object,
          properties: {
          id: { type: :integer },
          product_id: { type: :integer },
          store_id: { type: :integer },
          items: { type: :integer },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: ['id', 'product_id', 'store_id', 'items', 'created_at', 'updated_at']

        prod = Product.create(name: 'Product Test 1', price: 10.0)
        store = Store.create(name: 'Store Test', address: 'Store First')
        let(:id) {
          StockItem.create(product_id: prod.id, store_id: store.id, items: 5).id
        }
        run_test!
      end
    end
  end

  path '/api/v1/stock_items/{id}/add_items' do
    put 'Add items to the stock' do
      tags 'Stock Items'
      parameter name: :id, in: :path, schema: { type: :integer }
      parameter name: :stock_item, in: :body, schema: {
        type: :object,
        properties: { items: { type: :integer, example: 3 } },
        required: ['items']
      }

      response '200', 'stock item updated' do
        schema type: :object, properties: {
          id: { type: :integer },
          product_id: { type: :integer },
          store_id: { type: :integer },
          items: { type: :integer },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: ['id', 'product_id', 'store_id', 'items', 'created_at', 'updated_at']

        prod = Product.create(name: 'Product Test 1', price: 10.0)
        store = Store.create(name: 'Store Test', address: 'Store First')
        let(:id) {
          StockItem.create(product_id: prod.id, store_id: store.id, items: 5).id
        }
        let(:stock_item) { { items: 6 } }
        run_test!
      end

      response '422', 'error adding stock item' do
        prod = Product.create(name: 'Product Test 1', price: 10.0)
        store = Store.create(name: 'Store Test', address: 'Store First')
        let(:id) {
          StockItem.create(product_id: prod.id, store_id: store.id, items: 5).id
        }
        let(:stock_item) { { items: -6 } }
        run_test!
      end
    end
  end

  path '/api/v1/stock_items/{id}/remove_items' do
    put 'Remove items from the stock' do
      tags 'Stock Items'
      parameter name: :id, in: :path, schema: { type: :integer }
      parameter name: :stock_item, in: :body, schema: {
        type: :object,
        properties: { items: { type: :integer, example: 3 } },
        required: ['items']
      }

      response '200', 'stock item updated' do
        schema type: :object, properties: {
          id: { type: :integer },
          product_id: { type: :integer },
          store_id: { type: :integer },
          items: { type: :integer },
          created_at: { type: :string },
          updated_at: { type: :string }
        },
        required: ['id', 'product_id', 'store_id', 'items', 'created_at', 'updated_at']

        prod = Product.create(name: 'Product Test 1', price: 10.0)
        store = Store.create(name: 'Store Test', address: 'Store First')
        let(:id) {
          StockItem.create(product_id: prod.id, store_id: store.id, items: 5).id
        }
        let(:stock_item) { { items: 2 } }
        run_test!
      end

      response '422', 'error removing stock item' do
        prod = Product.create(name: 'Product Test 1', price: 10.0)
        store = Store.create(name: 'Store Test', address: 'Store First')
        let(:id) {
          StockItem.create(product_id: prod.id, store_id: store.id, items: 5).id
        }
        let(:stock_item) { { items: 6 } }
        run_test!
      end
    end
  end
end
