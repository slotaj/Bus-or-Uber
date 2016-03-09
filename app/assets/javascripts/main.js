$(document).ready(function(){
  // googleEstimate(response);
  // uberEstimate(response);
  bindEvents()
});

function bindEvents(){
  $('#get-estimate-button').on('click', function(){
    var orignInput = $('#origin-input').val()
    var destinationInput = $('#destination-input').val()
    getGoogleEstimate(orignInput, destinationInput)
    // retrive the from values to send as params
    // trigger an ajax call to the estimates controller
    // on success, get the data, pass the data to the googleEstimate function
    // on success, get the data, pass the data to the uberEstimate function
    // response.googleEstimate
    debugger
  })
}


function getGoogleEstimate(orignInput, destinationInput) {
  $.ajax({
    url: '/api/v1/env_variables.json',
    type: 'GET',
    success: function(response) {
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

function googleEstimate(response){
  console.log('in GoogleEstimate', response);

  tripDirections(response)
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
    "</button>" + "</td>" +
    " </tr>")
}

function uberEstimate(response){
  console.log('in UberEstimate', response);

  var data = JSON.parse(response.responseText).uber_estimate.ride_estimates
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
