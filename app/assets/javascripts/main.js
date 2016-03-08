$(document).ready(function(){
  $(document).ajaxSuccess(function(event, response, settings) {
    console.log(response);
    googleEstimate(response)
  })
});

function googleEstimate(response){
  debugger
  $('#bus-trips').append("<h1>" + JSON.parse(response.responseText).google_estimate.estimate_info.arrival_time.text + "</h1>")
}
