var keymap = {
  'a' : "/attack_all",
  'n' : "/next",
  'q' : "/auto",
};


$(document ).on( "click", "a.ajax" , function() {
  url = $( this ).attr("href") ;
  // alert("ajax");
  $.ajax({
    url: url,
    success: function( data ) {
      $('body').html(data);
    },
    error: function( data ) {
      $('body').html(data);
    }
  });
  return false;
});

if(window.location.pathname  == "/game"){

$( document ).keypress(function( event ) {
  key = String.fromCharCode(event.which)
  if( keymap[key] ){
    $.ajax({
      url: keymap[key],
      success: function( data ) {
        $('body').html(data);
      },
      error: function( data ) {
        $('body').html(data);
      }
    });
  }
});


var es = new EventSource('/comet');
es.onmessage = function(e) {
  // $("#logs").prepend(</br>');
  $.ajax({
    url: window.location.href,
    success: function( data ) {
      $('body').html(data);
    }
  });
};

}
