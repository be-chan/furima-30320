class PurchaseRecodesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find_params, only: [:index, :create]
  before_action :move_to_index
  before_action :sold_out_index

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_address_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_address_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to root_path unless @item.user_id != current_user.id
  end

  def sold_out_index
    redirect_to root_path if @item.purchase_recode.present?
  end

  def purchase_address_params
    params.require(:purchase_address).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def item_find_params
    @item = Item.find(params[:item_id])
  end
end
