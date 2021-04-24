class Api::V1::BackgroundsController < ApplicationController
  before_action :invalid_location?

  def index
    return render_error('Invalid location.', :not_acceptable) if invalid_location?

    background = BackgroundsFacade.get_background(params[:location])
    render json: ImageSerializer.new(background)
  end
end
