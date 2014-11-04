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

// pulse = setInterval(function() {
//     $.ajax({
//       url: "/pulse",
//       success: function( data ) {
//         if( $('#md5').text() != data ){
//           $.ajax({
//             url: "/game",
//             success: function( data ) {
//               alert("reload");
//               pageReloaded(data);
//             }
//           });
//         }
//       },
//     });
// }, 5000);
//
// }


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
