class Product < ApplicationRecord
  validates_presence_of :name, :price
  validates :price, numericality: { greater_than: 0 }
  has_many :stock_items, dependent: :destroy
end
