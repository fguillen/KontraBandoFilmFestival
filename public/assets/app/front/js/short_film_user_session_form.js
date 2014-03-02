console.log("short_film_user_session_form.js");

$(function(){
  if( $("#short_film_user_session_form").length > 0 ) {
    $("#short_film_user_session_form").validationEngine("init");

    $("#short_film_user_session_form").submit(function (event) {
      if(!$("#short_film_user_session_form").validationEngine("validate")) {
        event.preventDefault();
      }
    });
  }
})