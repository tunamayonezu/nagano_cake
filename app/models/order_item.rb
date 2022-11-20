class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order

  enum production_status: { sroduction_not_allowed: 0, waiting_for_production: 1, in_production: 2, production_completed: 3 }

  def total_price
    (item.price * 1.1).floor * quantity
  end
  ###############


end
