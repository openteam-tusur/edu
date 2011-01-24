function ajax_start() {
  if (!$(".ajax_overlay").length) {
    $("<div class='ajax_overlay'><div class='indicator'></div></div>").appendTo("body");
  };
  var indicator = $(".ajax_overlay .indicator");
  var overlayWidth = $(window).width();
  var overlayHeight = $(document).height();
  $(".ajax_overlay").css("width", overlayWidth);
  $(".ajax_overlay").css("height", overlayHeight);
  var winWidth = $(window).width();
  var winHeight = $(window).height();
  $(indicator).css('top',  winHeight/2-$(indicator).height()/2 + $(document).scrollTop());
  $(indicator).css('left', winWidth/2-$(indicator).width()/2);
  $(".ajax_overlay").show();
};

function ajax_stop() {
  $(".ajax_overlay").remove();
};

function discipline_name_autocomplete() {
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
  var linka = $('.human_check');
  linka.click(function() {
    var surname = $('#employee_surname').val();
    var name = $('#employee_name').val();
    var patronymic = $('#employee_patronymic').val();
    $.ajax({
      type: "GET",
      url: linka.attr('href'),
      data: {'surname': surname, 'name': name, 'patronymic': patronymic},
      beforeSend: function() {
        ajax_start();
      },
      complete: function() {
        ajax_stop();
      },
      success: function(data, textStatus, XMLHttpRequest) {
        $('.employees_list').html(data);
      }
    });
    return false;
  });
};

function get_discipline_educations(value) {
  $.ajax({
    type: "GET",
    url: "/autocompletes/discipline_educations",
    data: {"discipline_id": value},
    beforeSend: function() {
      ajax_start();
    },
    complete: function() {
      ajax_stop();
    },
    success: function(data, textStatus, XMLHttpRequest) {
      $("#publication_discipline_educations").html(data);
    }
  });
};

function publication_discipline_autocomplete() {
  $("#publication_discipline_discipline_id").live("change", function() {
    $("#publication_discipline_discipline_request").val("");
  });
  $("#publication_discipline_discipline_request").autocomplete({
    source: "/autocompletes/disciplines?speciality_id=" + $("#publication_discipline_speciality_id").val(),
    minLength: 2,
    select: function(event, ui) {
      $("#publication_discipline_discipline_id").val(ui.item.id);
      get_discipline_educations(ui.item.id);
    }
  });
};

function speciality_autocomplete() {
  $("#publication_discipline_speciality_request").autocomplete({
    source: "/autocompletes/specialities",
    minLength: 2,
    select: function(event, ui) {
      $("#publication_discipline_speciality_id").val(ui.item.id);
      $("#publication_discipline_discipline_request").removeAttr("disabled").focus().val("");
      $("#publication_discipline_educations").html("");
      publication_discipline_autocomplete();
    }
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
      var hidden_input = "<input type='hidden' value="+human_id+" name='publication[authors_attributes]["+human_index+"][human_id]' >";
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

function manipulation_publication_fields(){
  $("#publication_kind").change(function(){
    var kind = $(this).val();
    var id = $(".publication_id input").val();
    $.ajax({
      type: "POST",
      url: "/manage/publications/get_fields",
      data: $('.formtastic').serialize(),
      beforeSend: function() {
        ajax_start();
      },
      complete: function() {
        ajax_stop();
      },
      success: function(data, textStatus, XMLHttpRequest){
        $(".publication_fields").html(data);
      }
    });
  });
};

$(function() {
  human_check();
  discipline_name_autocomplete();
  author_autocomplete();
  speciality_autocomplete();
  add_author_in_list();
  delete_author_from_list();
  manipulation_publication_fields();
  flash();
  $(".focus_first:first").focus();
  $("a[rel=tipsy], abbr[rel=tipsy], span[rel=tipsy], .formtastic .inputs abbr").tipsy({gravity: "s"});
  $("a[rel=tipsy-left]").tipsy({gravity: "e"});
  $(".formtastic .inputs .date input").datepicker({
    showOn: "button",
    buttonImage: "/images/icon_datepicker.png",
    showOtherMonths: true,
    changeMonth: true,
    changeYear: true
  });
});

