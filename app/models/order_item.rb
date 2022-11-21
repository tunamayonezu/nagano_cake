class OrderItem < ApplicationRecord

  belongs_to :item
  belongs_to :order
#{}内を英語に変える
  enum production_status: { start_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }

  def total_price
    (item.price * 1.1).floor * quantity
  end
  ###############


end
