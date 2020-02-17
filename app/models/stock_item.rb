class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store
  validates_presence_of :product, :store
  validates :items, numericality: { greater_than_or_equal_to: 0 }
  validates :product, uniqueness: { scope: :store }

  def add_stock_item(number)
    if number.positive?
      self.update(items: self.items += number)
    else
      raise ArgumentError.new(
        'Invalid amount to add to stock. It must be a positive number.'
      )
    end
  end

  def remove_stock_item(number)
    if number.positive?
      self.update(items: self.items -= number)
    else
      raise ArgumentError.new(
        'Invalid amount to add to stock. It must be a positive number.'
      )
    end
  end
end
