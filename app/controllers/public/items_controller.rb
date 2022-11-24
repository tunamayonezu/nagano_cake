class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page])
      @items_count = @genre.items.all.count
    elsif @search_items
      @items = @search_items.page(params[:page])
      @items_count = @search_items.all.count

    else
      @items = Item.page(params[:page])
      @items_count = Item.all.count
    end



  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.page(params[:page])
    @cart_item = CartItem.new
  end
end
