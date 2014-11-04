$(document ).on( "click", "a.ajax" , function() {
  url = $( this ).attr("href") ;
  // alert("ajax");
  var c = lastUpdate;
  $.ajax({
    url: url,
    success: function( data ) {
      pageReloaded(data);
    },
    error: function( data ) {
      $('body').html(data);
    }
  });
  return false;
});


function ajaxClick(){


}
