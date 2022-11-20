class Admin::OrderItemsController < ApplicationController

 def update
    @order = Order.find_by(params[:id])
    @order_item = OrderItem.find(params[:id])
    @order_items = @order.order_items.all

    is_updated = true
    if @order_item.update(order_item_params)

     #@order.order_itmes.any?{|order_item| order_itme.production_status == "製作中"}
        @order.update(status: 2)
        if @order_item.production_status == "製作中"
          @order_items.each do |order_item|
            if order_item.production_status != "製作完了"
            is_updated = false
      end
      #if @order.order_itmes.all?{|order_itme| order_itme.production_status == "製作完了"}
        #@order.update(status: "発送準備中")
      end
      @order.update(status: 3 ) if is_updated
    end

      redirect_to admin_order_path(@order_itme.order)
  end



  private

  def order_item_params
    params.require(:order_itme).permit(:production_status)
  end
end


end
