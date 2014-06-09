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

  // sponsors

  $('#cmsms_clients_slider55').cmsmsClientsSlider( {
    sliderBlock : '#cmsms_clients_slider55',
    sliderItems : '.cmsms_clients_items',
    clientsInPage : 4
  } );

}); //ready
