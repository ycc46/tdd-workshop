require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'Get #show' do
    before :each do
      @user =create :user
      get :show, params: { id:@user.id }
    end

    it { should respond_with 200 }

    it "returns a user response" do
      json_response = JSON.parse response.body, symbolize_names: true
      expect(json_response[:email]).to eq @user.email
    end
  end

  describe 'Post #create' do
    context 'when create successfully' do
      before :each do
        @user_attributes = attributes_for :user
        post :create,params: {user: @user_attributes}
      end

      it { should respond_with 201 }

      it "returns the user record just create" do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response[:email]).to eq @user_attributes[:email]
      end
    end

    context 'when created failed' do
      before :each do
        @invalid_user_attributes = { password: '123456',password_confirmation: '123456' }
        post :create,params: { user:@invalid_user_attributes}
      end

      it { should respond_with 422 }

      it 'render errors json' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response).to have_key(:errors)
      end

      it "render errors json with details message" do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response[:errors][:email]).to include("can't be blank")
      end
    end
  end

  describe 'Put #update' do
    context 'when update successfully' do
      before :each do
        @user = create :user
        @user_attributes_email = { email: '123@qq.com' }
        put :update,params: { id: @user.id,user: @user_attributes_email }
      end

      it { should respond_with 200 }

      it 'returns the user record just update' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response[:email]).to eq @user_attributes_email[:email]
      end

    end

    context 'when update failed' do
      before :each do
        @user = create :user
        @invalid_user_attributes = { email: nil }
        put :update,params: { id: @user.id,user: @invalid_user_attributes }
      end

      it { should respond_with 422 }

      it 'render errors json' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response).to have_key(:errors)
      end

      it 'render errors json whith detail message' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response[:errors][:email]).to include("can't be blank")
      end
    end
  end

  describe 'Delete #destroy' do
    context 'when destroy successfully' do
      before :each do
        @user = create :user
        delete :destroy,params: { id: @user.id }
      end

      it { should respond_with 204 }

      it 'returns the result just destroy' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response[:result]).to eq 'success'
      end
    end

    context 'when destroy failed' do
      before :each do
        @user = create :user
        delete :destroy,params: { id: '0' }
      end

      it { should respond_with 404 }

      it 'render errors json' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response).to have_key(:errors)
      end

      it 'render errors json whith detail message' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response[:errors]).to include("Not found")
      end

    end

  end

end
