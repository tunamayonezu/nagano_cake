class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])#オーダーのidを探して参照する　どの注文なのか
    @order_item = OrderItem.where(order_id: @order.id) #showの@order_itemで注文商品の中のオーダーidを探してる
  end

  def update
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
    if @order.update(order_params)#ストロングパラメータで安全に更新する
      if @order.status == "payment_confirmation"# 英語に変える もしも注文ステータスが入金確認なったら
        @order_items.update_all(production_status: 1)#製作ステータスの全てを製作待ちに変える
      end
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end

