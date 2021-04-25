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

      created_user = User.last

      expect(response).to be_successful
      expect(response).to have_http_status(:created)

      expect(created_user.email).to eq(@user_info[:email])
      expect(created_user.api_key).to be_a(String)
    end
  end

  describe 'sad path' do
  end
end
