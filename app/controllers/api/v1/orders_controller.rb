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

  # def create
  #   toys = Toy.where(id: params[:toy_ids])
  #   @order = current_user.orders.new(total: toys.pluck(:price).sum)
  #   if toys.present? && @order.save
  #     toys.each do |toy|
  #       @order.placements.create(toy_id: toy.id)
  #     end
  #     render json: OrdersSerializer.new(@order), status: 201
  #   else
  #     render json: { errors: ErrorSerializer.new(@order).serialized_json }, status: 422
  #   end
  # end


  def create
    order = current_user.orders.build
    order.build_placements params[:order][:toy_ids_and_quantites]

    if order.save
      render json: OrdersSerializer.new(order), status: 201
    else
      render json: { errors: ErrorSerializer.new(order).serialized_json }, status: 422
    end
  end


end
