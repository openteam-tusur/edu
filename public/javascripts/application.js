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
      $(this).attr("human_id",ui.item.id);
    }
  });
};

function add_author_in_list(){
  var autocomplete_input = $(".author_query_input");
  autocomplete_input.after("<a href='#' class='add_author_link button'>Добавить автора</a>");

  var link = $(".add_author_link");
  var human_index = 0;
  var author_item = $(".author_item");
  if (author_item.length > 0) {
    human_index = parseInt (author_item.attr("id"));
  };

  link.live("click",function(){
    var human_id = autocomplete_input.attr("human_id");

    var human_exsits = $(".human_"+human_id);
    if (human_exsits.length > 0) {

      human_exsits.show();

    } else {

      var full_name = autocomplete_input.val();
      var delete_link = "<a href='#'>Удалить</a>";
      human_index++;
      var hidden_input = "<input type='hidden' value="+human_id+" name='work_programm[authors_attributes]["+human_index+"][human_id]' >";
      var human_item = "<p class='human_item human_"+human_id+"'><span class='full_name'>"+full_name+"</span>"+delete_link+hidden_input+"</p>"

      $(".author_list").append(human_item);
    };

    autocomplete_input.val("").attr("human_id","");
    $(this).hide();

    return false;
  });
};

function delete_author_from_list(){
  $(".human_item a").live("click", function(){
    $(this).parent().remove();

    return false;
  });

  $(".author_item a").click(function(){
    $(this).parent().hide();
    var name = $(this).siblings('.hidden_input').val('true');

    return false;
  });
};


$(function() {
  human_check();
  discipline_autocomplete();
  author_autocomplete();
  add_author_in_list();
  delete_author_from_list();
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

