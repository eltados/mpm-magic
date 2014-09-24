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
