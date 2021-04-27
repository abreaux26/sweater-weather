class Api::V1::RoadTripController < ApplicationController
  def create
    return render_error('Bad request. Try again.') if request.raw_post.blank?

    road_trip_info = JSON.parse(request.raw_post, symbolize_names: true)
    user = User.find_by(api_key: road_trip_info[:api_key])
    road_trip_details = RoadTripFacade.get_details(road_trip_info)
    return render json: RoadtripSerializer.new(road_trip_details) if user
    render_error('Unauthorized. Try again.', :unauthorized)
  end
end
