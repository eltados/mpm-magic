var keymap = {
  'a' : "/attack_all",
  'n' : "/next",
  'q' : "/auto",
  ']' : "/clear",
  ' ' : "/next",
};

showSpinner = false;
$( document ).ajaxStart(function() {
  showSpinner = true;
  setTimeout( function(){
     if(showSpinner){
      $( "#spinner" ).show();
     }
  }, 300);
});

$( document ).ajaxComplete(function() {
  showSpinner = false;
  $( "#spinner" ).hide();
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
    },
    error: function( data ) {
      $('body').html(data);
    }
  });
};



}




$.fn.arrow = function( target , options) {
    var settings = $.extend({}, options );
    drawLine(this, target);
    return this;

  function drawLine( source, target){
    topDiv = (target.offset().top <= source.offset().top ) ? target : source ;

    var template = $('#template').html();
    Mustache.parse(template);
    // y_1 = source.offset().top;
    // y_2 = target.offset().top;

    // if( source == topDiv ) {
    //   y_1 = y_1 + topDiv.innerHeight();
    // }else{
    //   y_2 = y_2 + topDiv.innerHeight();
    // }
    y_1 = source.offset().top + source.innerHeight() / 2;
    y_2 = target.offset().top + target.innerHeight() / 2;
    x_1 = source.offset().left + source.width() / 2;
    x_2 = target.offset().left + target.width() / 2;

    var rendered = Mustache.render(template, {
       x1: x_1 , y1: y_1 ,
       x2: x_2 , y2: y_2
    } );
    $('body').append(rendered);


  }
};
