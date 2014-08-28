
  $(document ).on( "click", "a.ajax" , function() {
    url = $( this ).attr("href") ;
    // alert("ajax");
    $.ajax({
      url: url,
      success: function( data ) {
        $('body').html(data);
        $("#logs").prepend(url+'</br>');
      }
    });
    return false;
  });


var es = new EventSource('/comet');
es.onmessage = function(e) {
    // $("#logs").prepend(</br>');
  $.ajax({
    url: window.location.href,
    success: function( data ) {
      $('body').html(data);
      $("#logs").prepend('comet !</br>');
    }
  });
};
