$(document).ready(function(){
  bindEvents();
  saveUberTrip();
  saveGoogleTrip();
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
      saveUberTrip();
    }, error: function(xhr) {
    }
  })
}

function saveGoogleTrip(){
 $('#save-google-trip').on('click', function(event){
   event.preventDefault()
   var trip_type      = $('.g-ride-type').text()
   var price_estimate = $('.g-ride-cost').text()
   var duration       = $('.g-ride-duration').attr('class')
   var distance       = $('.g-ride-distance').text()
   var postParams = { trip_type: trip_type,
           price_estimate: price_estimate,
           duration: duration,
           distance: distance }
   $.ajax({
     url: '/api/v1/user_trips',
     type: 'POST',
     data: postParams,
     dataType: null,
     success: function(response){
       alert("Trip Saved");
     },
     error: function(xhr) {
       alert("Uh Oh, Something went wrong")
       console.log(xhr.responseText)
    }
   })
 })
}

function saveUberTrip(){
 $('.save-uber-trip').on('click', function(){
   var trip_type      = $(this).siblings('.u-ride-type').text()
   var price_estimate = $(this).siblings('.u-ride-estimate').text()
   var duration       = $(this).siblings('.u-ride-duration').text()
   var distance       = $(this).siblings('.u-ride-distance').text()
   var high_estimate  = $(this).siblings('.u-ride-high-estimate').text()
   var low_estimate   = $(this).siblings('.u-ride-low-estimate').text()
   var postParams = { trip_type: trip_type,
                 price_estimate: price_estimate,
                       duration: duration,
                       distance: distance,
                  high_estimate: high_estimate,
                   low_estimate: low_estimate }
   $(this).parent().siblings().toggleClass('hidden')
   $.ajax({
     url: '/user_trips',
     type: 'POST',
     data: postParams,
     success: function(response){
       alert("Trip Saved");
     },
     error: function(xhr) {
       alert("Ayy ayy eye")
    }
   })
 })
}

function googleEstimate(google_data){
  tripDirections(google_data)
  $('#bus-trips tbody').children().remove()
  $('#bus-trips tbody').append(
    "<tr>" +
    "<td class='g-ride-type'>RTD Bus</td>" +
    "<td class='g-ride-cost'>$5.20</td>" +
    "<td class='g-ride-departure'>" + google_data.departure_time.text + "</td>" +
    "<td class='g-ride-arrival'>" + google_data.arrival_time.text + "</td>" +
    "<td class='g-ride-duration' class='" + google_data.duration.value + "'>" + google_data.duration.text + "</td>" +
    "<td class='g-ride-distance'>" + google_data.distance.text + "</td>" +
    "<td class='save-google-trip'>" + "<button type='button' class='btn btn-primary btn-sm'>" +
    "Take trip / Save info" +
    "</button>" + "</td>" +
    " </tr>")
}


function uberEstimate(uber_data){
  $('#uber-trips tbody').children().remove()
    // "localized_display_name"=>"uberX", "high_estimate"=>38, "minimum"=>5, "duration"=>1740, "estimate"=>"$29-38", "distance"=>23.23, "display_name"=>"uberX", "product_id"=>"b746437e-eab6-44ca-8079-25dfd6f861ab", "low_estimate"=>29, "surge_multiplier"=>1.0, "currency_code"=>"USD", "uber_arrival"=>9
  $('#uber-trips tbody').append(
  "<tr>" +
  "<td class='u-ride-type'>" + uber_data.localized_display_name + "</td>" +
  "<td class='u-ride-estimate'>" + uber_data.estimate + "</td>" +
  "<td>" + uber_data.uber_arrival + "</td>" +
  "<td class='u-ride-duration'>" + uber_data.duration + "</td>" +
  "<td class='u-ride-distance'>" + uber_data.distance + "</td>" +
  "<td class='u-ride-high-estimate'>" + uber_data.high_estimate + "</td>" +
  "<td class='u-ride-low-estimate'>" + uber_data.low_estimate + "</td>" +
  "<td>" + uber_data.minimum + "</td>" +
  "<td class='save-uber-trip'>" + "<button type='button' class='btn btn-primary btn-sm'>" +
  "Take trip / Save info" +
  "</button>" + "</td>" +
  "</tr>")
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
