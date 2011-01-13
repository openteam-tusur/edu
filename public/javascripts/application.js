function flash() {
  $("#error_explanation").addClass("flash_block").prepend("<a href=\"#\">закрыть</a>");
  $(".flash_block a").click(function(e) {
    e.preventDefault();
    $(this).parent().fadeOut(function() {
      $(this).remove();
    });
  });
};

function human_check(){
  linka = $('.human_check');

  linka.click(function() {
    url = linka.attr('href');
    surname = $('#employee_surname').val();
    name = $('#employee_name').val();
    patronymic = $('#employee_patronymic').val();
    $.get(
      url,
      {'surname': surname, 'name': name, 'patronymic': patronymic},
      function(data) {
        $('.employees_list').html(data);
      }
    );
    return false;
  });
};

$(function() {
  $(".curriculum_resource_state").prev().append($(".curriculum_resource_state"));
  human_check();
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
});

