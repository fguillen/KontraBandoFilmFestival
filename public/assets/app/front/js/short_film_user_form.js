$(function(){
  if( $("#short_film_user_form").length > 0 ) {
    $("#short_film_user_form").validationEngine("init");

    $("#short_film_user_form").submit(function (event) {
      var form_builder_url = $("#contact_form_url").val();

      if(!$("#short_film_user_form").validationEngine("validate")) {
        event.preventDefault();
      }
    });
  }
})