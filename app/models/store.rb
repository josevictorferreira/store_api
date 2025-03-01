class Store < ApplicationRecord
  validates_presence_of :name, :address
  validates :name, length: { minimum: 3 }
  validates :address, length: { minimum: 3 }
  has_many :stock_items, dependent: :destroy
end
