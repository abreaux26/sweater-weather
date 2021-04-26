class ApplicationController < ActionController::API
  private

  def invalid_location?
    params[:location].blank?
  end

  def invalid_destination?
    params[:destination].blank?
  end

  def render_error(error, status = :bad_request)
    render json: { message: 'your request cannot be completed', error: error }, status: status
  end
end
