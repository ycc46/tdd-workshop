require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe 'Get #show' do
    before :each do
      @user = create :user
      @order = create :order, user: @user
      api_authorization_header @user.auth_token
      get :show, params: { id:@order.id, user_id: @user.id }
    end

    it { should respond_with 200 }

    it "returns a order response" do
      expect(json_response[:data][:attributes][:total]) == @order.total
      expect(json_response[:data][:attributes][:user_id]).to eq @order.user_id
    end

    it "returns order relationships in order" do
      #binding.pry
      expect(json_response[:data][:relationships][:user][:data][:id].to_i).to eq @order.user.id
    end
  end

  describe 'Get #idenx' do
    before :each do
      @user = create :user
      4.times { create :order,user: @user }
      api_authorization_header @user.auth_token
      get :index, params: { user_id: @user.id }
    end

    it { should respond_with 200 }

    it 'returns a order response' do
      expect(json_response[:data].count).to eq 4
    end
  end

  # describe 'Post #create' do
  #   context 'when create successfully' do
  #     before :each do
  #       @user = create :user
  #       @toy1 = create :toy,user: @user
  #       @toy2 = create :toy,user: @user
  #       api_authorization_header @user.auth_token
  #       post :create, params: { order: { toys: [@toy1.id, @toy2.id] }, user_id: @user.id }
  #     end
  #
  #     it { should respond_with 201 }
  #
  #     it "returns the order record just create" do
  #       expect(json_response[:data][:attributes][:user_id]).to eq @user[:id]
  #       expect(json_response[:data][:attributes][:total]).to eq @order_attributes[:total]
  #     end
  #   end
  # end





end
