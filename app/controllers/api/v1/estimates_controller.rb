class Api::V1::EstimatesController < Api::ApiController
  respond_to :json
  def index
    google_estimate = GoogleEstimate.create(params[:origin],
                                            params[:destination])
    start_lat  = google_estimate.estimate_info['start_location']['lat']
    start_lng  = google_estimate.estimate_info['start_location']['lng']
    end_lat    = google_estimate.estimate_info['end_location']['lat']
    end_lng    = google_estimate.estimate_info['end_location']['lng']
    UberEstimate.create(start_lat, start_lng, end_lat, end_lng)

    google_estimate = GoogleEstimate.estimate
    uber_estimate = UberEstimate.estimate
    response = { google_estimate: google_estimate, uber_estimate: uber_estimate}
    respond_with response
  end

  # private
  #
  # def estimates_params
  #   params.require(:estimates).permit(:origin, :destination)
  # end
end
