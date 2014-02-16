$(document).ready(function() {
  // slider

  if ($.fn.cssOriginal != undefined)
    $.fn.css = $.fn.cssOriginal;

  if($('#rev_slider_1_1').revolution == undefined) {
    revslider_showDoubleJqueryError('#rev_slider_1_1');
  } else {
    $('#rev_slider_1_1').show().revolution({
      delay:9000,
      startwidth:755,
      startheight:580,
      hideThumbs:0,

      thumbWidth:100,
      thumbHeight:50,
      thumbAmount:3,

      navigationType:"bullet",
      navigationArrows:"nexttobullets",
      navigationStyle:"round",

      touchenabled:"on",
      onHoverStop:"off",

      navigationHAlign:"right",
      navigationVAlign:"bottom",
      navigationHOffset:0,
      navigationVOffset:15,

      soloArrowLeftHalign:"left",
      soloArrowLeftValign:"center",
      soloArrowLeftHOffset:0,
      soloArrowLeftVOffset:0,

      soloArrowRightHalign:"right",
      soloArrowRightValign:"center",
      soloArrowRightHOffset:0,
      soloArrowRightVOffset:0,

      shadow:0,
      fullWidth:"on",
      fullScreen:"off",

      stopLoop:"off",
      stopAfterLoops:-1,
      stopAtSlide:-1,

      shuffle:"off",

      hideSliderAtLimit:0,
      hideCaptionAtLimit:0,
      hideAllCaptionAtLilmit:0,
      startWithSlide:0,
      videoJsPath:"http://riviera.cmsmasters.net/wp-content/plugins/revslider/rs-plugin/videojs/",
      fullScreenOffsetContainer: ""
    });
  }

  // short_films list

  $('#portfolio_shortcode_1 .post_type_list').cmsmsResponsiveContentSlider( {
    sliderWidth : '100%',
    sliderHeight : 'auto',
    animationSpeed : 500,
    animationEffect : 'slide',
    animationEasing : 'easeInOutExpo',
    pauseTime : 0,
    activeSlide : 1,
    touchControls : true,
    pauseOnHover : false,
    arrowNavigation : true,
    slidesNavigation : false
  });

  // sponsors

  $('#cmsms_clients_slider55').cmsmsClientsSlider( {
    sliderBlock : '#cmsms_clients_slider55',
    sliderItems : '.cmsms_clients_items',
    clientsInPage : 5
  } );
}); //ready
