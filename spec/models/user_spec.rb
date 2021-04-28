require 'rails_helper'
RSpec.describe User do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of :api_key }
  end

  before :each do
    @user_info = {
                   email: "whatever@example.com",
                   password: "password",
                   password_confirmation: "password"
                 }
  end

  describe '.set_api_key' do
    it 'will have an api_key automatically assigned when created' do
      user = User.create(@user_info)
      expect(user.api_key).not_to be_nil
    end
  end

  describe 'sad path' do
    it 'no email' do
      bad_user_info = {
                     password: "password",
                     password_confirmation: "password"
                   }
      user = User.create(bad_user_info)
      expect(user.api_key).to be_nil
    end

    it 'no password' do
      bad_user_info = {
                        email: "whatever@example.com",
                        password_confirmation: "password"
                      }
      user = User.create(bad_user_info)
      expect(user.api_key).to be_nil
    end

    it 'no password_confirmation' do
      bad_user_info = {
                        email: "whatever@example.com",
                        password: "password"
                      }
      user = User.create(bad_user_info)
      expect(user.api_key).to be_nil
    end
  end
end
