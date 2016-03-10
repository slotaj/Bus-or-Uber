$(document).ready(function(){
  bindEvents();
  saveUberTrip();
  collapseTable('#uber-trip-table')
  collapseTable('#bus-trip-table')
});


function collapseTable(id) {
   $(id).on('click', function() {
     $(this).next().toggleClass('hidden');
   });
 };

function bindEvents(){
  $('#get-estimate-button').on('click', function(){
    var orignInput = $('#origin-input').val();
    var destinationInput = $('#destination-input').val();
    getEstimates(orignInput, destinationInput);
  })
}

function saveGoogleTrip(){
 $('#save-google-trip').on('click', function(event){
   event.preventDefault()
   var trip_type      = $('#g-ride-type').text()
   var price_estimate = $('#g-ride-cost').text()
  //  var duration       = $('#g-ride-duration').text()
   var duration       = $('#g-ride-duration').attr('class')
   debugger
   var distance       = $('#g-ride-distance').text()
   var postParams = { trip_type: trip_type,
           price_estimate: price_estimate,
           duration: duration,
           distance: distance }
   $.ajax({
     url: '/api/v1/user_trips',
     type: 'POST',
     data: postParams,
     success: function(response){
       console.log('google trip saved', response)
     },
     error: function(xhr) {
      console.log("noonono", xhr.responseText)
    }
   })
 })
}

function saveUberTrip(){
 $('#save-uber-trip').on('click', function(){
   var trip_type      = $('#u-ride-type').text()
   var price_estimate = $('#u-ride-estimate').text()
   var duration       = $('#u-ride-duration').text()
   var distance       = $('#u-ride-distance').text()
   var high_estimate  = $('u-ride-high-estimate').text()
   var low_estimate   = $('u-ride-low-estimate').text()
   var postParams = { trip_type: trip_type,
                 price_estimate: price_estimate,
                       duration: duration,
                       distance: distance,
                  high_estimate: high_estimate,
                   low_estimate: low_estimate }
   $.ajax({
     url: '/user_trips',
     type: 'POST',
     data: postParams,
     success: function(response){
       console.log("uber trip saved", response)
     },
     error: function(xhr) {
      console.log(xhr.responseText)
    }
   })
  //  debugger
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
      saveGoogleTrip();
    }, error: function(xhr) {
    }
  })
}


function googleEstimate(google_data){
  tripDirections(google_data)
  $('#bus-trips tbody').children().remove()
  $('#bus-trips tbody').append(
    "<tr>" +
    "<td id='g-ride-type'>RTD Bus</td>" +
    "<td id='g-ride-cost'>$5.20</td>" +
    "<td id='g-ride-departure'>" + google_data.departure_time.text + "</td>" +
    "<td id='g-ride-arrival'>" + google_data.arrival_time.text + "</td>" +
    "<td id='g-ride-duration' class='" + google_data.duration.value + "'>" + google_data.duration.text + "</td>" +
    "<td id='g-ride-distance'>" + google_data.distance.text + "</td>" +
    "<td>" + "<button type='button' class='btn btn-primary btn-sm' id='save-google-trip'>" +
    "Take trip / Save info" +
    "</button>" + "</td>" +
    " </tr>")
}

function uberEstimate(uber_data){
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
      "<td>" + "<button type='button' class='btn btn-primary btn-sm' id='save-uber-trip'>" +
      "Take trip / Save info" +
      "</button>" + "</td>" +
      "</tr>"
    )
  })
}

function tripDirections(google_data){
  var start_address = google_data.start_address
  var end_address = google_data.end_address
  var steps = google_data.steps
  $('#bus-trip-directions > p').remove()
  $('#bus-trip-directions').append(
    "<p><h3>Origin:</h3> " + start_address + "</p>" +
    "<p><h3>Destination:</h3> " + end_address + "</p><br>" +
    "<p><h3>Steps</h3></p>"
  )
  steps.forEach(function(step){
    $('#bus-trip-directions').append(
      '<p>' + step.travel_mode  + ': ' +
      'Go ' + step.distance.text + ' for ' + step.duration.text + ' ' +
      step.html_instructions + '</p>'
    )
  })
}
