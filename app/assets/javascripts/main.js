$(document).ready(function(){
  $(document).ajaxSuccess(function(event, response, settings) {
    console.log(response);
    googleEstimate(response)
    uberEstimate(response)
  });
});


function googleEstimate(response){
  var data = JSON.parse(response.responseText).google_estimate.estimate_info
  $('#bus-trips tbody').children().remove()
  $('#bus-trips tbody').append(
    "<tr>" +
    "<td>RTD Bus</td>" +
    "<td>Moneys</td>" +
    "<td id='departure_time'>" + data.departure_time.text + "</td>" +
    "<td id=''>" + data.arrival_time.text + "</td>" +
    "<td>" + data.duration.text + "</td>" +
    "<td>" + data.distance.text + "</td>" +
    "<td>" + "<button type='button' class='btn btn-primary btn-sm' id='bus-trip-id'>" +
    "Take trip / Save info" +
              //     {controller: 'user_trips',
              //          action: 'create',
              //  user_trip_info: { trip_type: 'bus',
              //               price_estimate: '$',
              //                     duration: @google_estimate.duration,
              //                     distance: @google_estimate.distance}
              //                   }}, class: 'btn btn-primary btn-sm' %>" +
    "</button>" + "</td>" +
    " </tr>")
}

function uberEstimate(response){
  var data = JSON.parse(response.responseText).uber_estimate.ride_estimates
  console.log(data)
  $('#uber-trips tbody').children().remove()
    data.forEach(function(uber_trip) {
      $('#uber-trips tbody').append(
      "<tr>" +
      "<td>" + uber_trip.table.localized_display_name + "</td>" +
      "<td>" + uber_trip.table.estimate + "</td>" +
      "<td>" + uber_trip.table.estimated_uber_arrival + "</td>" +
      "<td>" + uber_trip.table.duration + "</td>" +
      "<td>" + uber_trip.table.distance + "</td>" +
      "<td>" + uber_trip.table.high_estimate + "</td>" +
      "<td>" + uber_trip.table.low_estimate + "</td>" +
      "<td>" + uber_trip.table.minimum + "</td>" +
      "<td>" + "<button type='button' class='btn btn-primary btn-sm' id='bus-trip-id'>" +
      "Take trip / Save info" +
      "</button>" + "</td>" +
      "</tr>"
    )
  })
}
