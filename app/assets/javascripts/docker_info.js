//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
//#
//#
//#query_dockerimages = (dockerserver_id) ->
//#  $('body').append "Ulala"
//#
//#do query_dockerimages

function query_dockerimages(server_id) {
  $.ajax({
    url: "/imageurls/" + server_id + ".json",
    type: 'get',
//    data: $(this).serialize()
    data: $(this)
//    data: { name: "John", location: "Boston" }
    }).done(function(data){ 
//      alert(data)
      change_select(data);
    });
  
  }

function change_select(data) {
  alert(data)
  var json = jQuery.parseJSON(data);
  var options = [];
  json.forEach(function(key, index) {
    options.push({text: index, value: key});
  })
  $('#run_image_url').replaceOptions(options);

}

