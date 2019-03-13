require 'rails_helper'

RSpec.describe Api::V1::ToysController, type: :controller do
  describe 'Get #idenx' do
    before :each do
      @toy_1 = create :toy
      @toy_2 = create :toy
      @toy_3 = create :toy
      get :index
    end

    it { should respond_with 200 }

    it 'returns a toy response' do
      expect(json_response[:data].count).to eq 3
      expect(json_response[:data][0][:id].to_i).to eq @toy_1.id
      expect(json_response[:data][1][:id].to_i).to eq @toy_2.id
      expect(json_response[:data][2][:id].to_i).to eq @toy_3.id
    end
  end

  describe 'Get #show' do
    before :each do
      @toy = create :toy
      get :show, params: { id: @toy.id }
    end

    it { should respond_with 200 }

    it "returns a toy response" do
      expect(json_response[:data][:attributes][:title]).to eq @toy.title
      expect(json_response[:data][:attributes][:price]) == @toy.price
      expect(json_response[:data][:attributes][:user_id]).to eq @toy.user_id
      expect(json_response[:data][:attributes][:published]).to eq @toy.published
    end

    it "returns user relationships in toy" do
      # binding.pry
      expect(json_response[:data][:relationships][:user][:data][:id].to_i).to eq @toy.user.id
    end
  end

  describe 'Post #create' do
    context 'when create successfully' do
      before :each do
        @toy_attributes = attributes_for :toy
        @user = create :user
        api_authorization_header @user.auth_token
        post :create, params: { toy: @toy_attributes, user_id: @user.id }
      end

      it { should respond_with 201 }

      it "returns the toy record just create" do
        expect(json_response[:data][:attributes][:user_id]).to eq @user[:id]
        expect(json_response[:data][:attributes][:title]).to eq @toy_attributes[:title]
        expect(json_response[:data][:attributes][:price]) == @toy_attributes[:price]
        expect(json_response[:data][:attributes][:published]).to eq @toy_attributes[:published]
      end
    end
  end

  describe 'Put #update' do
    context 'when update successfully' do
      before :each do
        @toy = create :toy
        @user = User.find(@toy.user_id)
        api_authorization_header @user.auth_token
        @toy_attributes = { title: 'toy1' }
        put :update, params: { id: @toy.id, toy: @toy_attributes, user_id: @user.id }
      end

      it { should respond_with 200 }

      it 'returns the toy record just update' do
        expect(json_response[:data][:attributes][:title]).to eq @toy_attributes[:title]
        expect(json_response[:data][:attributes][:user_id]).to eq @user.id
      end
    end

    context 'when update failed' do
      before :each do
        @toy = create :toy
        @user = User.find(@toy.user_id)
        api_authorization_header @user.auth_token
        @toy_attributes = { title: nil }
        put :update, params: { id: @toy.id, toy: @toy_attributes, user_id: @user.id }
      end

      it { should respond_with 422 }

      it 'render errors json' do
        # binding.pry
        expect(json_response).to have_key(:errors)
      end

      it 'render errors json whith detail message' do
        expect(json_response[:errors].first[:detail]).to include("can't be blank")
      end
    end
  end

  describe 'Delete #destroy' do
    context 'when destroy successfully' do
      before :each do
        @toy = create :toy
        @user = create :user
        api_authorization_header @user.auth_token
        @toy_attributes = { user_id: @user.id }
        delete :destroy, params: { id: @toy.id, toy: @toy_attributes }
      end

      it { should respond_with 204 }
    end
  end

end
