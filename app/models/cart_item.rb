class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  ############

  ##商品の金額×数量で合計金額を求める
  def total_price
    (item.price * 1.1).floor * quantity
  end

end
