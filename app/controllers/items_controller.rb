class ItemsController < ApplicationController
  # ログインしていないユーザーはログインページに促す
  before_action :authenticate_user!, except: [:index, :show]

  # 重複処理をまとめる
  # before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
  @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def update
    @item = Item.find(params[:id])
   if @item.update(item_params)
    # バリデーションがOKであれば詳細画面へ
      redirect_to item_path(item_params)
    else
      # NGであれば、エラー内容とデータを保持したままeditファイルを読み込み、エラーメッセージを表示させる
      render 'edit'
    end
  end
    
  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end

