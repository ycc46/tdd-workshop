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

  describe 'Create #create' do
    context 'when create successfully' do
      before :each do
        @user = create :user
        @toy_1 = create :toy
        @toy_2 = create :toy
        api_authorization_header @user.auth_token
        post :create, params: { toy_ids: [@toy_1.id, @toy_2.id], user_id: @user.id }
        #post :create, params: { user_id: @.id, order: { toy_ids: [@toy1.id, @toy2.id] } }
      end

      it { should respond_with 201 }

      it 'returns the user record just created' do
        expect(json_response[:data][:attributes][:user_id]).to eq @user.id
        expect(json_response[:data][:attributes][:total]) == (@toy_1.price + @toy_2.price).to_f.to_s
      end

      it 'returns user relationships in order' do
        expect(json_response[:data][:relationships][:user][:data][:id].to_i).to eq @user.id
      end
    end

    context 'when create failed' do
      before :each do
        @user = create :user
        api_authorization_header @user.auth_token
        post :create, params: { user_id: @user.id }
      end

      it { should respond_with 422 }

      it 'render errors json' do
        expect(json_response).to have_key(:errors)
      end
    end
  end




end
