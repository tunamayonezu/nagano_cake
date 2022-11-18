class Admin::HomesController < ApplicationController
  before_action :authenticate_admin! #ログインせずに入れないように

  def top
  @orders = Order.page(params[:page])
  end
end
