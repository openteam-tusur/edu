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
  $(".focus_first:first").focus();
  $('a[rel=tipsy], .formtastic .inputs abbr').tipsy({
    gravity: 's'
  });
  $(".formtastic .inputs .date input").datepicker({
    showOn: "button",
    buttonImage: "/images/icon_datepicker.png",
    showOtherMonths: true,
    changeMonth: true,
    changeYear: true
  });
});
