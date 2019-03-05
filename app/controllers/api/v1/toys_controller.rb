class Api::V1::ToysController < ApplicationController
  before_action :authenticate_with_token!, only: [:creat, :update]

  def index
    @toys = Toy.all
    render json: ToysSerializer.new(@toys), status: 200
  end

  def show
    @toy = Toy.find params[:id]
    render json: ToysSerializer.new(@toy)
  end

  def create
    toy = current_user.toys.new toy_params
    if toy.save
      render json: ToysSerializer.new(toy), status: 201
    else
      render json: { errors: ErrorSerializer.new(toy).serialized_json }, status: 422
    end
  end

  def update
    toy = current_user.toys.find params[:id]
    #binding.pry
    if toy.update_attributes toy_params
      render json: ToysSerializer.new(toy), status: 200
    else
      render json: { errors: ErrorSerializer.new(toy).serialized_json }, status: 422
    end
  end

  def destroy
    current_user.toys.destroy
    # binding.pry
    head 204
  end


  private

    def toy_params
      params.require(:toy).permit(:user_id, :title, :price, :published)
    end
end
