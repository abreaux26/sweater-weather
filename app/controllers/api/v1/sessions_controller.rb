class Api::V1::SessionsController < ApplicationController
  before_action :validate_params

  def create
    user_info = JSON.parse(request.raw_post, symbolize_names: true)
    user = User.find_by(email: user_info[:email])
    if user && user.authenticate(user_info[:password])
      render json: UsersSerializer.new(user)
    else
      render_error('Credentials are bad. Try again.', :not_found)
    end
  end

  private

  def validate_params
    return unless request[:email].blank? || request[:password].blank?

    render_error('Missing email or password. Try again.', :bad_request)
  end
end
