function flash() {
  $("#error_explanation").addClass("flash_block").prepend("<a href=\"#\">закрыть</a>");
  $(".flash_block a").click(function(e) {
    e.preventDefault();
    $(this).parent().fadeOut(function() {
      $(this).remove();
    });
  });
};

function revert_button() {
  $(".revert_with_title").prev().before($(".revert_with_title"));
};


$(function() {
  flash();
  $(".focus_first:first").focus();
  $("a[rel=tipsy], .formtastic .inputs abbr").tipsy({gravity: "s"});
  $("a[rel=tipsy-left]").tipsy({gravity: "e"});
  $(".formtastic .inputs .date input").datepicker({
    showOn: "button",
    buttonImage: "/images/icon_datepicker.png",
    showOtherMonths: true,
    changeMonth: true,
    changeYear: true
  });
  $("#education_discipline_name").autocomplete({
    source: "/manage/disciplines/search",
    minLength: 2
  });
  revert_button();
});
