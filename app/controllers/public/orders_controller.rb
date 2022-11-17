class Public::OrdersController < ApplicationController
#before_action :authenticate_customer

def new
end
    
def confirm
end

def complete
end
   
def create
end

def index
    @orders = Order.all #current_customer.orders
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