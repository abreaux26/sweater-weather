class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(JSON.parse(request.raw_post))
    if user.save
      render json: UsersSerializer.new(user), status: :created
    end
  end
end
