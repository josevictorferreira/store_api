class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store
  validates_presence_of :product, :store
  validates :items, numericality: { greater_than_or_equal_to: 0 }
  validates :product, uniqueness: { scope: :store }

  def add_stock_item(number)
    StockItem.add_items(self.id, number)
    self.reload
  end

  def remove_stock_item(number)
    StockItem.remove_items(self.id, number)
    self.reload
  end

  def self.add_items(item_id, num_items)
    if num_items.positive?
      StockItem.transaction do
        item = StockItem.find_by_id(item_id)
        item.with_lock do
          item.items += num_items
          item.save!
        end
      end
    else
      raise ArgumentError.new(
        'Invalid amount to add to stock. It must be a positive number.'
      )
    end
  end

  def self.remove_items(item_id, num_items)
    if num_items.positive?
      StockItem.transaction do
        item = StockItem.find_by_id(item_id)
        item.with_lock do
          item.items -= num_items
          item.save!
        end
      end
    else
      raise ArgumentError.new(
        'Invalid amount to add to stock. It must be a positive number.'
      )
    end
  end
end
