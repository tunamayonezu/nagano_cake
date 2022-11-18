class Public::OrdersController < ApplicationController
#before_action :authenticate_customer

def new
    @cart_items = current_customer.cart_items
    if @cart_items == nil
        render cart_items_path
    else
    @order = Order.new
    end
end
    
def confirm
end

def complete
end
   
def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
        @cart_items = current_customer.cart_items
        @cart_items.each do |cart_item|
            order_item = OrderItem.new(order_id: @order.id)
            order_item.price = cart_item.item.purchase_price
            order_item.quantiy = cart_item.quantiy
            order_item.item_id = cart_item.item_id
            order_item.save
        end
        @cart_items.destroy_all
        redirect_to orders_complete_path
    else
        render "new"
    end
end

def index
    @orders = current_customer.orders
end
    
def show
    @order = Order.find(params[:id])
    @order_item = OrderItem.where(order_id: @order.id)
end

end


private

def order_params
    params.require(:order).permit(:postage, :total_payment, :payment_method, :postcode, :address, :name)
end