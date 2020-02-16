require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'with valid attributes' do
    it 'should be valid when name and price are present' do
      product = Product.new(name: 'Product Test 1', price: 10.0)
      expect(product).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'should be invalid when name is not present' do
      product = Product.new(price: 10.0)
      expect(product).to be_invalid
    end

    it 'should be invalid when price is not present' do
      product = Product.new(name: 'Product Test 1')
      expect(product).to be_invalid
    end

    it 'should be invalid when name is an empty value' do
      product = Product.new(name: '', price: 10.0)
      expect(product).to be_invalid
    end

    it 'should be invalid when price is a negative number' do
      product = Product.new(name: 'Product Test 1', price: -10.0)
      expect(product).to be_invalid
    end
  end
end
