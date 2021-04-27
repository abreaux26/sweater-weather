require 'rails_helper'
RSpec.describe 'Login' do
  before :each do
    @user1 = User.create( email: "whatever@example.com",
                          password: "password",
                          password_confirmation: "password"
                        )
    @user_login_info = {
                   "email": "whatever@example.com",
                   "password": "password"
                 }
  end

  describe 'happy path' do
    it 'user can log in' do
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/sessions', headers: headers, params: JSON.generate(@user_login_info)

      login_info = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)

      expect(login_info[:data][:attributes].count).to eq(2)

      expect(login_info[:data]).to have_key(:id)
      expect(login_info[:data]).to have_key(:type)
      expect(login_info[:data][:attributes]).to have_key(:email)
      expect(login_info[:data][:attributes]).to have_key(:api_key)

      expect(login_info[:data][:id]).to be_a(String)
      expect(login_info[:data][:type]).to eq('users')

      expect(login_info[:data][:attributes][:email]).to be_a(String)
      expect(login_info[:data][:attributes][:api_key]).to be_a(String)

      expect(login_info[:data][:attributes][:email]).to eq(@user1 [:email])
      expect(login_info[:data][:attributes][:api_key]).to eq(@user1[:api_key])
    end
  end

  describe 'sad path' do
    it 'credentials are bad, password' do
      bad_user_login_info = {
                          "email": "whatever@example.com",
                          "password": "password123"
                        }
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/sessions', headers: headers, params: JSON.generate(bad_user_login_info)

      bad_login_info = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response).to have_http_status(:not_found)
    end

    it 'credentials are bad, email' do
      bad_user_login_info = {
                          "email": "whatever123@example.com",
                          "password": "password"
                        }
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/sessions', headers: headers, params: JSON.generate(bad_user_login_info)

      bad_login_info = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response).to have_http_status(:not_found)
    end

    it 'no body is passed' do
      headers = {"CONTENT_TYPE" => "application/json"}
      post '/api/v1/sessions', headers: headers

      expect(response).not_to be_successful
      expect(response).to have_http_status(:bad_request)
    end
  end
end
