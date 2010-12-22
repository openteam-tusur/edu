function flash() {
  $("#error_explanation").addClass("flash_block").prepend("<a href='#'>закрыть</a>");
  $(".flash_block a").click(function(e) {
    e.preventDefault();
    $(this).parent().fadeOut(function() {
      $(this).remove();
    });
  });
};

$(function() {
  flash();
  $('a[rel=tipsy]').tipsy({
    gravity: 's'
  });
});
