require 'rails_helper'
RSpec.describe 'User Registration' do
  before :each do
    @user_info = {
                   "email": "whatever@example.com",
                   "password": "password",
                   "password_confirmation": "password"
                 }
  end

  describe 'happy path' do
    it 'registers a user' do
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/users', headers: headers, params: JSON.generate(@user_info)

      new_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(:created)

      expect(new_user[:data][:attributes].count).to eq(2)

      expect(new_user[:data]).to have_key(:id)
      expect(new_user[:data]).to have_key(:type)
      expect(new_user[:data][:attributes]).to have_key(:email)
      expect(new_user[:data][:attributes]).to have_key(:api_key)

      expect(new_user[:data][:id]).to be_a(String)
      expect(new_user[:data][:type]).to eq('users')

      expect(new_user[:data][:attributes][:email]).to be_a(String)
      expect(new_user[:data][:attributes][:api_key]).to be_a(String)
      
      expect(new_user[:data][:attributes][:email]).to eq(@user_info[:email])
    end
  end

  describe 'sad path' do
  end
end
