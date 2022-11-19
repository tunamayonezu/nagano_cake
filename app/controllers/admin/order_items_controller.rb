class Admin::OrderItemsController < ApplicationController

  def show
    @order_items = OrderItems.where(order_id: params[:id])
    @order = Order.find(params[:id])
  end

end
