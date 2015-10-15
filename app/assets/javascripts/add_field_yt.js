$( document ).ready(function() {
  var i = 1
  $("#button").click(function() {
    $("#field")
      .append('<textarea class="label_text_yt" name="page[url_youtube][' + i +']" id="page_url_youtube"></textarea><br>');
    i = i + 1 ;
  });
});
