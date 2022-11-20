class Admin::OrderItemsController < ApplicationController

 def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    if @order_item.update(order_item_params)
      if @order.order_itmes.any?{|order_item| order_itme.production_status == "製作中"}
        @order.update(status: "製作中")
      end
      if @order.order_itmes.all?{|order_itme| order_itme.production_status == "製作完了"}
        @order.update(status: "発送準備中")
      end
      redirect_to admin_order_path(@order_itme.order)
    else
      render admin_order_path
    end
  end



  private

  def order_detail_params
    params.require(:order_itme).permit(:production_status)
  end
end


end
