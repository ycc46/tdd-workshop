require 'rails_helper'

RSpec.describe Api::V1::ToysController, type: :controller do
  describe 'Get #show' do
    before :each do
      @toy = create :toy
      get :show, params: { id:@toy.id }
    end

    it { should respond_with 200 }

    it "returns a toy response" do
      expect(json_response[:data][:attributes][:title]).to eq @toy.title
      expect(json_response[:data][:attributes][:price]) == @toy.price
      expect(json_response[:data][:attributes][:user_id]).to eq @toy.user_id
      expect(json_response[:data][:attributes][:published]).to eq @toy.published

    end
  end

  describe 'Post #create' do
    context 'when create successfully' do
      before :each do
        @toy_attributes = attributes_for :toy
        @user = create :user
        api_authorization_header @user.auth_token
        post :create, params: { toy: @toy_attributes }
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

end
