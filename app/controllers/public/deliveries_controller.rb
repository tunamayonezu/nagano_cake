class Public::DeliveriesController < ApplicationController

  def index
    @delivery = Delivery.new
    #カスタマーIDを指定
    @customer = Customer.find(current_customer.id)
    #顧客の登録している配送先の情報を@deliveriesに代入
    @deliveries = @customer.deliveries

  end

  def create
    @customer = Customer.find(current_customer.id)
    @delivery = Delivery.new(delivery_params)
    @deliveries = @customer.deliveries
    @delivery.customer_id = current_customer.id
   if @delivery.save
    redirect_to  deliveries_path
   else
    render "index"
   end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
     @delivery = Delivery.find(params[:id])

      if @delivery.update(delivery_params)
       redirect_to deliveries_path
      else
       render "edit"
      end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path

  end

  def delivery_params
    params.require(:delivery).permit(:name, :postcode, :address)
  end

end
