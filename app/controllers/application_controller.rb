class ApplicationController < ActionController::API
  def render_error(error, status = :bad_request)
    render json: { message: 'your request cannot be completed', error: error }, status: status
  end

  private
  
  def invalid_location?
    params[:location].blank?
  end
end
