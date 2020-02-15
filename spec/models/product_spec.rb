require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'should be valid when name and price are present' do
    user = Product.new(name: 'Product Test 1', price: 10.0)
    expect(user).to be_valid
  end

  it 'should be invalid when name is not present' do
    user = Product.new(price: 10.0)
    expect(user).to be_invalid
  end

  it 'should be invalid when price is not present' do
    user = Product.new(name: 'Product Test 1')
    expect(user).to be_invalid
  end

  it 'should be invalid when name is an empty value' do
    user = Product.new(name: '', price: 10.0)
    expect(user).to be_invalid
  end

  it 'should be invalid when price is a negative number' do
    user = Product.new(name: 'Product Test 1', price: -10.0)
    expect(user).to be_invalid
  end
end
