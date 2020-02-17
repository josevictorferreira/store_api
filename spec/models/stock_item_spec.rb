require 'rails_helper'

RSpec.describe StockItem, type: :model do

  before(:each) do
    @product = Product.create(name: 'Test Product', price: 45.0)
    @store = Store.create(name: 'Store 1', address: 'Road Test')
  end

  context 'with valid attributes' do
    it 'should be valid when product, store and items are present' do
      item = StockItem.new(product: @product, store: @store, items: 3)
      expect(item).to be_valid
    end

    it 'should be valid when items is not present' do
      item = StockItem.new(product: @product, store: @store)
      expect(item).to be_valid
    end

    it 'Default number of items when no value is passed should be 0' do
      item = StockItem.create(product: @product, store: @store)
      expect(item.items).to be_equal(0)
    end
  end

  context 'with invalid attributes' do
    it 'should be invalid when product is not present' do
      item = StockItem.new(store: @store, items: 5)
      expect(item).to be_invalid
    end

    it 'should be invalid when store is not present' do
      item = StockItem.new(product: @product, items: 5)
      expect(item).to be_invalid
    end

    it 'should be invalid when the number of items is less then 0' do
      item = StockItem.new(product: @product, store: @store, items: -1)
      expect(item).to be_invalid
    end

    it 'should be invalid when already have a stock item with the same store and product' do
      StockItem.create(product: @product, store: @store, items: -1)
      item = StockItem.new(product: @product, store: @store, items: -1)
      expect(item).to be_invalid
    end
  end

  describe "Add Stock Item" do
    before(:each) do
      @stock_item = StockItem.create(product: @product, store: @store, items: 3)
    end

    context 'with valid number of items' do
      it 'should save and update the number of items for the stock item' do
        @stock_item.add_stock_item(3)
        expect(@stock_item).to be_truthy
        expect(@stock_item.items).to be_equal(6)
      end
    end

    context 'with invalid number of items' do
      it 'raise exception when the argument is a negative number' do
        expect{@stock_item.add_stock_item(-1)}.to raise_exception(ArgumentError)
      end
    end
  end

  describe 'Remove Stock Item' do
    before(:each) do
      @stock_item = StockItem.create(product: @product, store: @store, items: 3)
    end

    context 'with valid number of items' do
      it 'should save and update the number of items for the stock item' do
        @stock_item.remove_stock_item(3)
        expect(@stock_item).to be_truthy
        expect(@stock_item.items).to be_equal(0)
      end
    end

    context 'with invalid number of items' do
      it 'should not update the number of items when the number to be removed is larger than the actual stock' do
        expect{@stock_item.remove_stock_item(5)}.to raise_exception(ActiveRecord::RecordInvalid)
      end

      it 'raise exception when the argument is a negative number' do
        expect{@stock_item.remove_stock_item(-5)}.to raise_error(ArgumentError)
      end
    end
  end
end
