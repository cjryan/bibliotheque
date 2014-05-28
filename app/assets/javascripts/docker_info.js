
function query_dockerimages(server_id) {
  var url = "/imageurls/1.json"
  response = jQuery.getJSON(url)
  $.getJSON( url, function( data ) {
    var items = [];
    $.each( data, function( key, val ) {
      items.push(val);
    })
    replace_guts(items)
  });
  };

function replace_guts(options) {
  alert(options[0].tag)
  
  var $el = $("#run_image_url");
  $el.empty();
  $.each(options, function(key,value) {
  $el.append($("<option></option>")
     .attr("value", value.id).text(value.tag));
});
}
