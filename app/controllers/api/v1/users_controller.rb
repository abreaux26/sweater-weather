class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(JSON.parse(request.raw_post))
    if user.save
      render json: UsersSerializer.new(user), status: :created
    else
      render_error(user.errors.full_messages.to_sentence)
    end
  end
end
