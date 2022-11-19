class Public::OrdersController < ApplicationController
#before_action :authenticate_customer

def new
    @cart_items = current_customer.cart_items ##ログインカスタマーのカート内アイテムを指定
    if @cart_items == nil ##カート内アイテムの有無を確認
        render cart_items_path ##cart_itemsに戻る
    else
    @order = Order.new
    end
end
    
def confirm
    @cart_items = current_customer.cart_items ##ログインカスタマーのカート内アイテムを指定
    @order = Order.new(order_params) ##オーダー新規登録
    @order.payment_method = params[:order][:payment_method] ##支払方法を反映
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price } ##cart_itemsから1つずつ取り出して合計金額が出せるらしい
    @order.postage = 800 ##配達料金は800円
    
    ## ご自身の住所から選択
    if params[:order][:address_option] == "0" ##どれを選択したのかをparamsから読み取る
        @order.postcode = current_customer.postcode ##郵便番号を反映
        @order.address = current_customer.address ##住所を反映
        @order.name = current_customer.last_name + " " + current_customer.first_name ##名前を反映
        render "confirm" ##confirmに戻る
        
    ## 登録済住所から選択
    elsif params[:order][:address_option] == "1" ##どれを選択したのかをparamsから読み取る
        @delivery = Delivery.find_by(params[:order][:deliveries_id]) ##どの登録済住所を選択したのかを反映させる
        @order.postcode = @delivery.postcode ##郵便番号を反映
        @order.address = @delivery.address ##住所を反映
        @order.name = @delivery.name ##名前を反映
        render "confirm"
    
    ## 新規登録を選択
    elsif params[:order][:address_option] == "2"##どれを選択したのかをparamsから読み取る
        @delivery = current_customer.deliveries.new ##配達先を新規登録
        @delivery.postcode = params[:order][:postcode] ##郵便番号を登録
        @delivery.address = params[:order][:address] ##住所を登録
        @delivery.name = params[:order][:name] #名前を登録
        @delivery.customer_id = current_customer.id ##デリバリーカスタマーIDをログインしているカスタマーIDに指定
        if @delivery.save ##新規登録した住所を保存
            @order.postcode = @delivery.postcode ##郵便番号を反映
            @order.address = @delivery.address ##住所を反映
            @order.name = @delivery.name ##名前を反映
        end
    else
        render "new" ##newに戻る
    end
        
end

def complete
end
   
def create
    @order = Order.new(order_params) ##オーダー新規作成
    @order.customer_id = current_customer.id ##オーダーカスタマーIDをログインしているカスタマーIDに指定
    if @order.save ## 保存
        @cart_items = current_customer.cart_items ##カート内アイテムにログインしているカスタマーのカート内アイテムを反映
        
        @cart_items.each do |cart_item| ## カート内アイテムを1つずつ取り出す---------------
            order_item = OrderItem.new(order_id: @order.id) ##取り出すたびにIDを指定（？）  |
            order_item.price = cart_item.item.price * 1.1 ##消費税を反映させる              |
            order_item.quantiy = cart_item.quantiy ##数量を反映させる                       |        
            order_item.item_id = cart_item.item_id ##商品を反映させる                       |
            order_item.save ##保存                                                         \|/ 繰り返し
        end
        
        @cart_items.destroy_all ##カート内アイテムはもういらないから消す（まだdestroy_all使用不可）
        redirect_to complete_path ##注文完了画面に変移
    else
        render "new" ##newに戻る
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