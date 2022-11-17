class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
  
  ############
  
  def total_price
    item.purchase_price * quantity
  end
  
  def self.cart_items_total_payment(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.item.purchase_price * cart_item.quantity
    end
    return(array.sum * 1.1).floor.to_s(:delimited)
  end
end
