$(document).ready(function(){
  bindEvents()
});

function bindEvents(){
  $('#get-estimate-button').on('click', function(){
    var orignInput = $('#origin-input').val();
    var destinationInput = $('#destination-input').val();
    getEstimates(orignInput, destinationInput);
  })
}


function getEstimates(orignInput, destinationInput) {
  $.ajax({
    url: '/api/v1/estimates',
    type: 'GET',
    data: { origin: orignInput, destination: destinationInput },
    success: function(response){
      var google_data = response.google_estimate.estimate_info
      var uber_data = response.uber_estimate.ride_estimates

      googleEstimate(google_data)
      uberEstimate(uber_data)

      console.log('SUCCESS', response);
    }, error: function(xhr) {
      console.log('NO', xhr);
    }
  })
}




function tripDirections(response){
  var data = JSON.parse(response.responseText).google_estimate.estimate_info
  $('#bus-trip-directions > p').remove()
  $('#bus-trip-directions').append(
    "<p><h3>Origin:</h3> " + data.start_address + "</p>" +
    "<p><h3>Destination:</h3> " + data.end_address + "</p><br>"
  )
}

function googleEstimate(google_data){
  console.log('in GoogleEstimate', google_data.departure_time.text);
  // tripDirections(response)
  $('#bus-trips tbody').children().remove()
  $('#bus-trips tbody').append(
    "<tr>" +
    "<td>RTD Bus</td>" +
    "<td>Moneys</td>" +
    "<td id='departure_time'>" + google_data.departure_time.text + "</td>" +
    "<td id=''>" + google_data.arrival_time.text + "</td>" +
    "<td>" + google_data.duration.text + "</td>" +
    "<td>" + google_data.distance.text + "</td>" +
    "<td>" + "<button type='button' class='btn btn-primary btn-sm' id='bus-trip-id'>" +
    "Take trip / Save info" +
    "</button>" + "</td>" +
    " </tr>")
}

function uberEstimate(uber_data){
  console.log('in UberEstimate', uber_data);
  // debugger
  $('#uber-trips tbody').children().remove()
    uber_data.forEach(function(uber_trip) {
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
// retrive the from values to send as params
// trigger an ajax call to the estimates controller
// on success, get the data, pass the data to the googleEstimate function
// on success, get the data, pass the data to the uberEstimate function
// response.googleEstimate
// debugger
