class Api::V1::ToysController < ApplicationController
  before_action :authenticate_with_token!, only: [:creat]
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


  private

  def toy_params
    params.require(:toy).permit(:user_id, :title, :price, :published)
  end



end
