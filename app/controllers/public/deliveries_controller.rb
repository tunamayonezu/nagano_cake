class Public::DeliveriesController < ApplicationController

  def index
    @delivery = Delivery.new
    @deliveries = Delivery.all
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @deliveries = Delivery.all
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
