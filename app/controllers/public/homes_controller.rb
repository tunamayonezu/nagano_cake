class Public::HomesController < ApplicationController
  
  def top
    @item = Item.order(created_at: :desc).limit(5)
    @genres = Genre.page(params[:page])
  end

  def about
  end
  
end
