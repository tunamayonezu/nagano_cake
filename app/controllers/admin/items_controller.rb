class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    #商品の情報を全て読み込ませる
    @items = Item.all
  end

  def new
    #viewへ渡すインスタンス変数に空のmodelオブジェクトを渡す
    @item = Item.new
    @genres = Genre.all
  end

  def show
    #idを参照して表示する商品を探す
    @item = Item.find(params[:id])
  end

  def edit
    #idを参照して編集する商品を探す
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
  def create
    #idを付与して商品を作成する
    @item = Item.new(item_params)
    if @item.save#作成が成功した場合
      redirect_to admin_item_path(@item.id)#作成した商品の詳細ページへ行く
    else#作成ができなかった場合
      render :new#作成画面へ戻る
    end
  end
  
  def update
    #idを参照して更新する商品を探す
    @item = Item.find(params[:id])
    @genres = Genre.all
    if @item.update(item_params)#更新が成功した場合
      redirect_to edit_admin_item_path#更新した商品の詳細ページへ行く
    else#更新ができなかった場合
      render 'edit'#編集画面へ戻る
    end
  end
  
  private
  
  def item_params#入力されたデータが、作成データとして許可されているパラメータか確認する
    params.require(:item).permit(:name, :explanation, :genre_id, :price, :in_active, :image)
  end
end
