$(document).ready(function(){
  var d = $('<div>').hide();
  $('body').append(d);
  d.dialog({
    modal: true,
    autoOpen: false,
    position: { my: 'top', at: 'top+70', of: window }
  });
  $('.carousel.full-view-avail img').click(function(){
    d.html('').append($(this).clone().css('margin','0px auto'));
    d.dialog( "option", "modal", true );
    d.dialog('open');
    setDSize();
  });

  $(window).resize(setDSize).resize();

  function setDSize() {
    d.dialog({
      'width': $(window).width() - 20,
      'maxHeight': $(window).height() - 100
    });
  }

  $(document).on('click', '.ui-widget-overlay', function(){
    d.dialog('close');
  });
});
