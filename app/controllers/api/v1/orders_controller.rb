class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token!, only: [:creat, :update]

  def show
    @order = Order.find params[:id]
    render json: OrdersSerializer.new(@order)
  end

  def index
    @orders = Order.all
    render json: OrdersSerializer.new(@orders), status: 200
  end

  def create
    order = current_user.orders.new order_params
    if order.save
      render json: OrdersSerializer.new(order), status: 201
    else
      render json: { errors: ErrorSerializer.new(order).serialized_json }, status: 422
    end
  end

  private

    def order_params
      params.require(:order).permit(:user_id, :toys[])
    end
end
