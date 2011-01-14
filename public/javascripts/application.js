function discipline_autocomplete() {
  $("#education_discipline_name").autocomplete({
    source: "/autocompletes/disciplines",
    minLength: 2
  });
};

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

function author_autocomplete(){
  $(".author_query_input").autocomplete({
    source: "/autocompletes/authors",
    minLength: 2,
    select: function(event, ui) {
      $(".add_author_link").show();
      $(this).attr("author_id",ui.item.id);
    }
  });
};

function add_author_in_list(){
  var autocomplete_input = $(".author_query_input");
  autocomplete_input.after("<a href='#' class='add_author_link button'>Добавить автора</a>");

  var link = $(".add_author_link");

  link.live("click",function(){
    var full_name = autocomplete_input.val();
    var author_id = autocomplete_input.attr("author_id");
    $(".author_list").append("<p id="+author_id+" class='author_item'>"+full_name+"</p>");
    autocomplete_input.val("").attr("author_id","");
    $(this).hide();

    return false;
  });
}


$(function() {
  human_check();
  discipline_autocomplete();
  author_autocomplete();
  add_author_in_list();
  flash();
  $(".focus_first:first").focus();
  $("a[rel=tipsy], span[rel=tipsy], .formtastic .inputs abbr").tipsy({gravity: "s"});
  $("a[rel=tipsy-left]").tipsy({gravity: "e"});
  $(".formtastic .inputs .date input").datepicker({
    showOn: "button",
    buttonImage: "/images/icon_datepicker.png",
    showOtherMonths: true,
    changeMonth: true,
    changeYear: true
  });
});

