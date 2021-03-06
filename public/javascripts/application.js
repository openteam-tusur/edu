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
  $("#study_discipline_name").autocomplete({
    source: "/autocompletes/disciplines?speciality_id="+$('#study_speciality_id').val(),
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
    human_index = parseInt (author_item.last().attr("id"));
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

function show_used_books(kind) {
  var used_books_block = $('fieldset.used_books');
  var used_book_list = used_books_block.children('.used_book_list');
  if (kind == 'work_programm') {
    used_books_block.show();
  } else {
    used_book_list.find('textarea, select, input').val('');
    used_book_list.find('#publication_used_books_attributes_new_used_books__destroy').val('1');
    used_book_list.find('.nested-fields').hide();
    used_books_block.hide();
  };
}

function catch_click() {
  $("#used_book_fields_template #publication_used_books_attributes_new_used_books__destroy").val('');
  $('.publication_title_field').publication_autocomplete();
  $(".add_link_wrapper .add_fields").live('click', function(){
    $('.publication_title_field').publication_autocomplete();
  });
}

function manipulation_publication_fields(){
  show_used_books($('#publication_kind').val());
  $("#publication_kind").change(function(){
    var kind = $(this).val();
    var id = $(".publication_id input").val();
    show_used_books(kind);
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

function manipulation_education_fields(){
  var linka = $('.add_new_education');
  if (linka) {
    linka.click(function(){

      $.ajax({
        type: "POST",
        url: "/manage/educations/get_fields",
        data: $('.formtastic').serialize(),
        beforeSend: function() {
          ajax_start();
        },
        complete: function() {
          ajax_stop();
        },
        success: function(data){
          $(".educations_list").append(data);
        }
      });
      return false;
    });
  };
};

function irregual_labels(){
  $('#study_educations_attributes_new_educations_examinations_input fieldset ol li label, #study_educations_attributes_new_educations_examinations_input fieldset ol li label>input').live('click',
    function(){
      if ($(this).is('label')) {
        id = $(this).attr('for');
        checkbox = $(this).children();
      };

      if ($(this).is('input')) {
        id = $(this).attr('id');
        checkbox = $(this);
      };

      if (checkbox.is(':checked')) {
        checkbox.removeAttr('checked');
      } else {
        checkbox.attr('checked','checked');
      };
    });
};

function expander() {
 $('.expand_link').click(function(){
  $(this).parent().next().slideToggle('fast');
  return false;
 }).parent().next().hide();
};

function publication_tabs(){
  if ($('.human_publications').length > 0){
    $('.human_publications .tabs a').click(function(){
      $('.active').removeClass('active');
      $(this).parent().addClass('active');
      var tab = $(this).parent().attr("id");
      $('.work_programm, .training_toolkit, .tutorial').hide();
      $('.'+tab).show();
      return false;
    });
  };
};

$.fn.publication_autocomplete = function () {
  $(this).live('keyup.autocomplete', function(){
    $(this).autocomplete({
      source: "/autocompletes/publications",
      minLength: 2,
      select: function(event, ui) {
        $(this).parent().siblings('.publication_code_input').children('input').val(ui.item.id);
      }
    });
  });
};

function prepare_main_menu() {
  $(".main_menu a").each(function() {
    if ($(this).closest("li").hasClass("target_blank")) {
      $(this).attr("target", "_blank").attr("rel", "nofollow noreferrer");
    };
  });
};

function rj_search_manipulate() {
  $(".cool_list .record .record_title a, .cool_list .record .record_keywords .more").click(function() {
    var link = $(this);
    var parent_block = link.closest("li");
    var table = $("table", $(this).parents("li"));
    table.toggle(0, function() {
      if (table.is(":visible")) {
        $(".more", parent_block).html("дополнительно &uarr;")
      } else {
        $(".more", parent_block).html("дополнительно &darr;");
      };
    });
    return false;
  });
  $(".abstract_list ..search_result .cool_list table tr").mouseenter(function() {
    $(this).css("background-color", "white");
  }).mouseleave(function() {
    $(this).css("background-color", "transparent");
  });
};

function init_checkbox_tree() {
  if ($.fn.tree) {
    $(".extend_search_toggle").click(function() {
      var link = $(this);
      $(".selected_filters").toggle();
      $(".extend_search").toggle(0, function() {
        if ($(".extend_search").is(":visible")) {
          link.html("расширенный поиск &uarr;")
        } else {
          link.html("расширенный поиск &darr;");
        };
      });
      return false;
    });
    $(".subjects_tree, .years_tree").tree({
      expand_checked_partial_on_load: true
    });
  };
};

$(function() {
  human_check();
  discipline_name_autocomplete();
  author_autocomplete();
  speciality_autocomplete();
  add_author_in_list();
  delete_author_from_list();
  manipulation_publication_fields();
  manipulation_education_fields();
  irregual_labels();
  catch_click();
  flash();
  expander();
  publication_tabs();
  $(".focus_first:first").focus();
  $("*[rel=tipsy], .formtastic .inputs abbr, .need_tipsy").tipsy({
    gravity: "s",
    html: true
  });
  $("a[rel=tipsy-left], .need_vert_tipsy").tipsy({gravity: "e"});
  $(".formtastic .inputs .date input").datepicker({
    yearRange: '1950:' + (new Date().getFullYear() + 10),
    showOn: "button",
    buttonImage: "/images/icon_datepicker.png",
    showOtherMonths: true,
    changeMonth: true,
    changeYear: true
  });
  $(".disciplines .tabs").tabs();
  prepare_main_menu();
  $(".role_facets #pending a").click(function() { return false; });
  rj_search_manipulate();
  init_checkbox_tree();
});

