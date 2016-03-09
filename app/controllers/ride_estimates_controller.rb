class RideEstimatesController < ApplicationController

  def index
    @google_estimate = GoogleEstimate.estimate
    @uber_estimate   = UberEstimate.estimate
  end

  # def create
  #   google_estimate = GoogleEstimate.create(estimates_params[:origin],
  #                                                estimates_params[:destination])
  #   start_lat  = google_estimate.estimate_info['start_location']['lat']
  #   start_lng  = google_estimate.estimate_info['start_location']['lng']
  #   end_lat    = google_estimate.estimate_info['end_location']['lat']
  #   end_lng    = google_estimate.estimate_info['end_location']['lng']
  #   UberEstimate.create(start_lat, start_lng, end_lat, end_lng)
  #   redirect_to action: 'index'
  # end

  # private
  #
  # def estimates_params
  #   params.require(:estimates).permit(:origin, :destination)
  # end
end
