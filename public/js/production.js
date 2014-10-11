$(document ).on( "click", "a.ajax" , function() {
  url = $( this ).attr("href") ;
  // alert("ajax");
var c = lastUpdate;
  $.ajax({
    url: url,
    success: function( data ) {
      $('body').html(data);

      $( '.log' ).each( function(){
          json = JSON.parse($( this ).attr("data-json"));
          if(json.time > c ){
            renderEvent(json);
          }
      }) ;


    },
    error: function( data ) {
      $('body').html(data);
    }
  });
  return false;
});
