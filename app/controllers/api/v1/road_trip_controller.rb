class Api::V1::RoadTripController < ApplicationController
  before_action :validate_params

  def create
    road_trip_info = JSON.parse(request.raw_post, symbolize_names: true)
    user = User.find_by(api_key: road_trip_info[:api_key])
    return render_error('Unauthorized. Try again.', :unauthorized) if user.nil?

    road_trip_details = RoadTripFacade.get_details(road_trip_info)
    render json: RoadtripSerializer.new(road_trip_details)
  end

  private

  def validate_params
    return unless request[:origin].blank? || request[:destination].blank? || request[:api_key].blank?

    render_error('Missing origin, destination, or api_key. Try again.', :bad_request)
  end
end
