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
    it 'missing an attribute' do
      bad_user_info = {
                     "email": "whatever@example.com",
                     "password": "password"
                   }

      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/users', headers: headers, params: JSON.generate(bad_user_info)

      expect(response).not_to be_successful
      expect(response.status).to eq 400
    end

    it 'passwords dont match' do
      bad_user_info = {
                     "email": "whatever@example.com",
                     "password": "password",
                     "password_confirmation": "password123"
                   }

      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/users', headers: headers, params: JSON.generate(bad_user_info)

      bad_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq 400
      expect(bad_user[:error]).to eq("Password confirmation doesn't match Password")
    end

    it 'email is already taken' do
      bad_user_info = {
                     "email": "whatever@example.com",
                     "password": "password",
                     "password_confirmation": "password"
                   }

      headers = {"CONTENT_TYPE" => "application/json"}

      User.create(@user_info)
      post '/api/v1/users', headers: headers, params: JSON.generate(bad_user_info)

      bad_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq 400
      expect(bad_user[:error]).to eq 'Email has already been taken'
    end

    it 'no body is passed' do
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/users', headers: headers

      expect(response).not_to be_successful
      expect(response).to have_http_status(:bad_request)
    end
  end
end
