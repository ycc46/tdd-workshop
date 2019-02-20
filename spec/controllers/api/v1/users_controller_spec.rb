require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'Get #show' do
    before :each do
      @user = create :user
      get :show, params: { id:@user.id }
    end

    it { should respond_with 200 }

    it "returns a user response" do
      expect(json_response[:data][:attributes][:email]).to eq @user.email
    end
  end

  describe 'Post #create' do
    context 'when create successfully' do
      before :each do
        @user_attributes = attributes_for :user
        post :create, params: { user: @user_attributes }
      end

      it { should respond_with 201 }

      it "returns the user record just create" do
        expect(json_response[:data][:attributes][:email]).to eq @user_attributes[:email]
      end
    end

    context 'when created failed' do
      before :each do
        @invalid_user_attributes = { password: '123456', password_confirmation: '123456' }
        post :create, params: { user: @invalid_user_attributes }
      end

      it { should respond_with 422 }

      it 'render errors json' do
        expect(json_response).to have_key(:errors)
      end

      it "render errors json with details message" do
        expect(json_response[:errors].first[:detail]).to include("can't be blank")
      end
    end
  end

  describe 'Put #update' do
    context 'when update successfully' do
      before :each do
        @user = create :user
        api_authorization_header @user.auth_token
        @user_attributes_email = { email: '123@qq.com' }
        put :update, params: { id: @user.id, user: @user_attributes_email }
      end

      it { should respond_with 200 }

      it 'returns the user record just update' do
        expect(json_response[:data][:attributes][:email]).to eq @user_attributes_email[:email]
      end

    end

    context 'when update failed' do
      before :each do
        @user = create :user
        api_authorization_header @user.auth_token
        @invalid_user_attributes = { email: nil }
        put :update, params: { id: @user.id, user: @invalid_user_attributes }
      end

      it { should respond_with 422 }

      it 'render errors json' do
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
        @user = create :user
        api_authorization_header @user.auth_token
        delete :destroy, params: { id: @user.id }
      end

      it { should respond_with 204 }
    end
  end

end
