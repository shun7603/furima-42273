class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]        # ← これを最初にする！
  before_action :redirect_if_sold_out, only: [:index, :create]
  before_action :redirect_if_seller, only: [:index, :create]
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @order_address = OrderAddress.new(order_params)
    puts "💡params[:token]: #{params[:token]}"
    puts "💡order_params[:token]: #{order_params[:token]}" # ← こっちが超重要！
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address,
      :phone_number, :building
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_seller
    return unless @item.user_id == current_user.id

    redirect_to root_path
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_if_sold_out
    return unless @item.order.present?

    redirect_to root_path
  end
end
