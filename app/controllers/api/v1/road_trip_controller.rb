class Api::V1::RoadTripController < ApplicationController
  def create
    road_trip_info = JSON.parse(request.raw_post, symbolize_names: true)
    user = User.find_by(api_key: road_trip_info[:api_key])
    road_trip_details = RoadTripFacade.get_details(road_trip_info)
    if user
      render json: RoadtripSerializer.new(road_trip_details)
    else
      render_error('Unauthorized. Try again.', :unauthorized)
    end
  end
end
