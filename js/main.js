// Generated by CoffeeScript 1.7.1
var quick_create_index, selected_task, show_create_modal, show_task_overlay;

quick_create_index = 0;

selected_task = null;

show_create_modal = function() {
  var title;
  $('#create-overlay').removeClass('hidden');
  title = $('#quick-create input[type=text]').val();
  $('#create-overlay #create-task .title').val(title);
  if (title.length > 0) {
    return $('#create-overlay #create-task .due-date').focus();
  } else {
    return $('#create-overlay #create-task .title').focus();
  }
};

show_task_overlay = function(original_task) {
  var new_task;
  new_task = original_task.clone();
  $('#overlay .selected-elem').html(new_task);
  $('#overlay .selected-elem').css(original_task.offset());
  console.log(original_task);
  $('#overlay').removeClass('hidden');
  return $('.modal').css({
    top: original_task.offset().top + (original_task[0].offsetHeight / 2) - 75,
    left: original_task.offset().left + original_task[0].offsetWidth + 15
  });
};

$(function() {
  $('#quick-create').on('keyup', 'input[type=text]', function(e) {
    var dropdown, text;
    if (e.which === 91) {
      return true;
    }
    text = $(this).val();
    dropdown = $('#quick-create .options');
    if (text.length > 0) {
      dropdown.removeClass('hidden');
      $('#quick-create .user-value').text(text);
    }
    if (e.which === 27) {
      dropdown.addClass('hidden');
    }
    if (e.which === 13) {
      return show_create_modal();
    }
  });
  $('#quick-create').on('submit', function(e) {
    $('#quick-create .options').addClass('hidden');
    return e.preventDefault();
  });
  $('#quick-create').on('click', 'a', function(e) {
    e.preventDefault();
    if ($(e.target).is('.create-with-options')) {
      return show_create_modal();
    }
  });
  $('body').on('click', function(e) {
    $('#quick-create .options').addClass('hidden');
    if (!$(e.target).is('.actions')) {
      $('#menu').addClass('hidden');
      return selected_task = null;
    }
  });
  $('#overlay').on('click', function(e) {
    if (e.target === this) {
      return $('#overlay').addClass('hidden');
    }
  });
  $('#create-overlay').on('click', function(e) {
    if (e.target === this) {
      return $('#create-overlay').addClass('hidden');
    }
  });
  $('.actions').on('click', function(e) {
    var menu;
    menu = $('#menu');
    e.preventDefault();
    selected_task = $(this).parent();
    menu.removeClass('hidden');
    return menu.css({
      top: e.pageY - 5,
      left: e.pageX + 15
    });
  });
  $('#menu').on('click', 'a', function(e) {
    e.preventDefault();
    e.preventDefault();
    return show_task_overlay(selected_task);
  });
  $('.task h4').on('click', function(e) {
    e.preventDefault();
    return show_task_overlay($(this).parent());
  });
  $('.task').on('dragstart dragend', function(e) {
    return $('.task-actions').toggleClass('invisible');
  });
  $('.task-actions div').on('dragenter', function(e) {
    console.log('drug over action ' + $(this).text());
    return $(this).siblings().addClass('fade-out');
  });
  return $('.task-actions div').on('dragleave', function(e) {
    return $(this).siblings().removeClass('fade-out');
  });
});
