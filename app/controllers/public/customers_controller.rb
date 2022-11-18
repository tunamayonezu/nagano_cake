class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
   @customer = Customer.find_by(params[:id])
  end

  def edit
    @customer = Customer.find_by(params[:id])
  end

  def update
   @customer = Customer.find_by(params[:id])
    if @customer.update(customer_params)
      redirect_to mypage_path
    else
      render "edit"
    end
  end

  def unsubscribe

  end

  def withdraw

  end

  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number)
  end

end
