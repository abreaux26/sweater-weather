class ApplicationController < ActionController::API
  private

  def invalid_location?
    params[:location].blank?
  end

  def render_error(error, status = :bad_request)
    render json: { message: 'Your request cannot be completed.', error: error }, status: status
  end
end
