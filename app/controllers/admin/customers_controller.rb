class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!


  def index
    @customers= Customer.page
    #ページネーションするページ　allだと全部出る
  end

  def show
    #@customer = Customer.find(params[:id])
  end

  def edit
    #@customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
    :postcode, :ddress, :phone_number, :email ,:is_deleted)
    #苗字・名前・苗字カナ・名前かな
    #郵便番号・住所・電話番号・メアド・会員ステータス(これはいるか分からん)
    #上記以外の物が入らないように設定
  end

end
