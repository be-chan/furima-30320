class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :item_find_params, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :item_purchase_recode, only: [:edit]
  def index
    @items = Item.all.order('id DESC')
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
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduce, :category_id, :state_id, :postage_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def correct_user
    redirect_to root_path unless current_user.id == @item.user.id
  end

  def item_find_params
    @item = Item.find_by(id: params[:id])
  end

  def item_purchase_recode
    redirect_to root_path if @item.purchase_recode.present?
  end
end
