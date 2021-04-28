class Api::V1::UsersController < ApplicationController
  before_action :validate_params

  def create
    user_info = JSON.parse(request.raw_post, symbolize_names: true)
    downcase(user_info)
    user = User.create(user_info)
    return render json: UsersSerializer.new(user), status: :created if user.save

    render_error(user.errors.full_messages.to_sentence)
  end

  private

  def downcase(user_info)
    user_info[:email].downcase!
  end

  def validate_params
    return unless request[:email].blank? || request[:password].blank? || request[:password_confirmation].blank?

    render_error('Missing email, password, or password_confirmation. Try again.', :bad_request)
  end
end
