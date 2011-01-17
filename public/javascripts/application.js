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
    },
    change: function(event, ui) {
      consolo.log(event);
      consolo.log(ui);
    }
  });
};

function get_discipline_educations() {
  $.ajax({
    type: "GET",
    url: "/autocompletes/discipline_educations",
    data: {"discipline_id": $("#resource_discipline_speciality_id").val()},
    success: function(data, textStatus, XMLHttpRequest) {
      console.log(data);
    }
  });
};

function discipline_autocomplete() {
  $("#resource_discipline_discipline_request").autocomplete({
    source: "/autocompletes/disciplines?speciality_id=" + $("#resource_discipline_speciality_id").val(),
    minLength: 2,
    select: function(event, ui) {
      $("#resource_discipline_discipline_id").val(ui.item.id);
    }
  });
};

function speciality_autocomplete() {
  $("#resource_discipline_speciality_request").autocomplete({
    source: "/autocompletes/specialities",
    minLength: 2,
    select: function(event, ui) {
      $("#resource_discipline_speciality_id").val(ui.item.id);
      $("#resource_discipline_discipline_request").removeAttr("disabled").focus();
      discipline_autocomplete();
    }
  });
};

function add_author_in_list(){
  var autocomplete_input = $(".author_query_input");
  autocomplete_input.after("<a href='#' class='add_author_link button'>Добавить автора</a>");

  var link = $(".add_author_link");
  var human_index = parseInt ($(".author_item").attr("id"));

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
      var human_item = "<p class='human_item human_"+human_id+"'>"+full_name+delete_link+hidden_input+"</p>"

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
  speciality_autocomplete();
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

