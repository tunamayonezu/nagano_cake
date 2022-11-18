class Public::DeliveriesController < ApplicationController

  def index
    #カスタマーIDを指定
    @customer = Customer.find(current_customer.id)
    #顧客の登録している配送先の情報を@deliveriesに代入
    @deliveries = @customer.deliveries
    
    @delivery = Delivery.new
  end

  def create
    #一覧表示のための記述
    @customer = Customer.find(current_customer.id)
    @deliveries = @customer.deliveries
    #配送先登録
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    @delivery.save
    redirect_to  deliveries_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def delivery_params
    params.require(:delivery).permit(:name, :postcode, :address)
  end

end
