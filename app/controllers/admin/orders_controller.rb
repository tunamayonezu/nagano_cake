class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_item = OrderItem.where(order_id: @order.id)

  end

  def update
    @order = Order.find(params[:id])
    @order_item = OrderItem.where(order_id: @order.id)
    if @order.update(order_params)
       #@order.status == "入金待ち"
       @order_item.update_all(production_status: 1)
         if @order.status == "製作待ち"
       #@order.status == "入金確認"
        #@order_item.update_all(production_status: "製作待ち")
      end
      redirect_to admin_order_path(@order)

    end
  end



  private

  def order_params
    params.require(:order).permit(:status)
  end
end
