class Admin::OrderItemsController < ApplicationController

  def update
      @order_item = OrderItem.find(params[:id])
      @order = @order_item.order

    if @order_item.update(order_item_params)
      if params[:order_item][:production_status] == "in_production"#英語に変える 注文した商品の製作ステータスが、もしも製作中だったら
        @order.update(status: 2)
        #注文ステータスを製作中に変えてかsら
        @order_item.update(order_item_params)#注文した商品(製作ステータス)を更新をする
      end
    end
    if @order.order_items.count == @order.order_items.where(production_status: "production_complete").count
      #もしも注文した商品の数と、製作完了した商品の数が一致したら
       @order.update(status: 3)#注文ステータスを発送準備中に変える
    end
      redirect_to admin_order_path(@order_item.order)
  end




  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end
end

