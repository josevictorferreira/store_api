require 'rails_helper'

RSpec.describe Store, type: :model do
  context 'with valid attributes' do
    it 'should be valid when name and address are present' do
      store = Store.new(name: 'Store Test 1', address: 'Road Test')
      expect(store).to be_valid
    end
  end

  context 'with invalid attributes' do
    it 'should be invalid when name is not present' do
      store = Store.new(address: 'Road Test')
      expect(store).to be_invalid
    end

    it 'should be invalid when address is not present' do
      store = Store.new(name: 'Store Test 1')
      expect(store).to be_invalid
    end

    it 'should be invalid when name length is less than three' do
      store = Store.new(name: 'Ab', address: 'Road Test')
      expect(store).to be_invalid
    end

    it 'should be invalid when address length is less than three' do
      store = Store.new(name: 'Store Test 1', address: 'Ab')
      expect(store).to be_invalid
    end
  end
end
