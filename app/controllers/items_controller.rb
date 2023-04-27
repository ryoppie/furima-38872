class ItemsController < ApplicationController
  # ログインしていないユーザーはログインページに促す
  before_action :authenticate_user!, except: [:index ]#, :show

  # 重複処理をまとめる
  # before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
  #  @items = Item.includes(:user).order('created_at DESC')
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

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

 # def set_item
 #   @item = Item.find(params[:id])
 # end

end
