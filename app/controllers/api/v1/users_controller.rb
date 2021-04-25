class Api::V1::UsersController < ApplicationController
  def create
    user_info = JSON.parse(request.raw_post, symbolize_names: :true)
    downcase(user_info)
    user = User.create(user_info)
    return render json: UsersSerializer.new(user), status: :created if user.save
    render_error(user.errors.full_messages.to_sentence)
  end

  private

  def downcase(user_info)
    user_info[:email].downcase!
  end
end
