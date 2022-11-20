class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items

  end

  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    if @order.update(order_params)
      if @order.status == "入金待ち"
        @order_items.update_all(production_status: "着手不可")
      elsif @order.status == "入金確認"
        @order_items.update_all(production_status: "製作待ち")
      end
      redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end



  private

  def order_params
    params.require(:order).permit(:status)
  end
end
