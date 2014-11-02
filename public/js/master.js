var keymap = {
  'a' : "/attack_all",
  'n' : "/notify",
  'q' : "/auto",
  ' ' : "/next",
  'r' : function(){ react(); },
};

showSpinner = false;
$( document ).ajaxStart(function() {
  showSpinner = true;
  clearInterval(timer);
  setTimeout( function(){
     if(showSpinner){
      $( "#spinner" ).show();
     }
  }, 1000);
});

$( document ).ajaxComplete(function() {
  showSpinner = false;
  $( "#spinner" ).hide();
});

$(document ).on( "click", ".abilities img" , function() {
  alert($( this ).attr("title"));
});

$(document ).on( "click", ".card .name" , function() {
  alert($( this ).attr("title"));
});

$(document ).on( "click", "div.log" , function() {
  json = JSON.parse($( this ).attr("data-json"));
  renderEvent(json);
});


$(document ).on( "click", "#test" , function() {
  alert(lastUpdate);
  $( '.log' ).each( function(){
      json = JSON.parse($( this ).attr("data-json"));
      if(json.time > lastUpdate ){
      alert(json);
        renderEvent(json);
      }
  }) ;
});

function renderEvent(json){
  $( '#' + json.card ).toggleClass('animate') ;
  $( '#' + json.card ).toggleClass(json.action) ;
  // $( '#' + json.card ).removeClass(json.action) ;
    // $( '#' + json.card ).removeClass("transition05") ;
  // setTimeout(function(){
    // $( '#' + json.card ).removeClass(json.action+"-action");
    // $( '#' + json.card ).addClass("transition05") ;
  // }, 300);

}

//
// function renderEvent(json){
//   $( '#' + json.card ).hide() ;
//   $( '#' + json.card ).addClass(json.action+"-action") ;
//   $( '#' + json.card ).show() ;
//   setTimeout(function(){
//     $( '#' + json.card ).removeClass(json.action+"-action")
//   }, 500);
//
// }

if(window.location.pathname  == "/game"){

$( document ).keypress(function( event ) {
  key = String.fromCharCode(event.which)
  if( keymap[key] ){
    if($.isFunction(keymap[key])){
      keymap[key]();
    }else{
      $.ajax({
        url: keymap[key],
        success: function( data ) {
          pageReloaded(data);
        },
        error: function( data ) {
          $('body').html(data);
        }
      });
    }
  }
});

var es = new EventSource('/comet');
es.onmessage = function(e) {
  $.ajax({
    url: window.location.href,
    success: function( data ) {
      pageReloaded(data);

    },
    error: function( data ) {
      $('body').html(data);
    }
  });
};
}


function dump(object){
  alert(JSON.stringify(object));
}


var loading = function() {
   var progressbar = $('#progressbar');
   progressbar.val(progressbar.val()+ 75 );
   if ( progressbar.val() >= progressbar.attr('max')) {
        clearInterval(timer);
        progressDone();
    }
};


var timer ;


function progressDone(){
  //  window.location = $("#next_link").attr("href") ;

  var c = lastUpdate;
  $.ajax({
    url: "/resolve",
    success: function( data ) {
      pageReloaded(data);
    },
    error: function( data ) {
      $('body').html(data);
    }
  });
}

// var animate = setInterval(function() { loading(); }, 75);



function react(){
  clearInterval(timer);
  $('#progressbar').hide();
  $('#react').hide();
}

$(document ).on( "click", "#react" , function() {
  react();
});

$(document).ready(function(){setupProgressbar()});

function setupProgressbar(){
    if($('#progressbar').length){
      var progressbar = $('#progressbar');
      progressbar.val(0);
      timer = setInterval(function() { loading(); }, 75);
  }
}




function pageReloaded(data , lastUpdate){
  $('body').html(data);

  $( '.log' ).each( function(){
      json = JSON.parse($( this ).attr("data-json"));
      if(json.time > lastUpdate ){
        renderEvent(json);
      }
  }) ;

  setupProgressbar();

}


// $.fn.arrow = function( target , options) {
//     var settings = $.extend({}, options );
//     drawLine(this, target);
//     return this;
//
//   function drawLine( source, target){
//     topDiv = (target.offset().top <= source.offset().top ) ? target : source ;
//
//     var template = $('#template').html();
//     Mustache.parse(template);
//     // y_1 = source.offset().top;
//     // y_2 = target.offset().top;
//
//     // if( source == topDiv ) {
//     //   y_1 = y_1 + topDiv.innerHeight();
//     // }else{
//     //   y_2 = y_2 + topDiv.innerHeight();
//     // }
//     y_1 = source.offset().top + source.innerHeight() / 2;
//     y_2 = target.offset().top + target.innerHeight() / 2;
//     x_1 = source.offset().left + source.width() / 2;
//     x_2 = target.offset().left + target.width() / 2;
//
//     var rendered = Mustache.render(template, {
//        x1: x_1 , y1: y_1 ,
//        x2: x_2 , y2: y_2
//     } );
//     $('body').append(rendered);
//
//
//   }
// };
