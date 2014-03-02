console.log("short_film_user_form.js");

$(function(){
  if( $("#short_film_user_form").length > 0 ) {
    $("#short_film_user_form").validationEngine("init");

    $("#short_film_user_form").submit(function (event) {
      if(!$("#short_film_user_form").validationEngine("validate")) {
        event.preventDefault();
      }
    });
  }
})