// Generated by CoffeeScript 1.7.1
require.config({
  baseUrl: 'js',
  paths: {
    'jquery': 'components/jquery/dist/jquery.min',
    'underscore': 'components/underscore/underscore',
    'backbone': 'components/backbone/backbone'
  }
});

require(['jquery', 'underscore', 'backbone', 'models/Task', 'views/QuickCreate', 'views/CreateModal'], function($, _, Backbone) {
  var CreateTask, QuickCreate, Task, create_modal, quick_create, quick_create_index, selected_task, show_task_detail_section, show_task_overlay;
  Task = require('models/Task');
  QuickCreate = require('views/QuickCreate');
  CreateTask = require('views/CreateModal');
  create_modal = new CreateTask();
  quick_create = new QuickCreate({
    create_modal: create_modal
  });
  quick_create_index = 0;
  selected_task = null;
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
  show_task_detail_section = function(section) {
    $('.sections a').removeClass('selected');
    $('.sections .' + section).addClass('selected');
    $('.section').removeClass('selected');
    return $('.section.' + section).toggleClass('selected');
  };
  return $(function() {
    console.log("doc ready");
    $('html').on('click', function(e) {
      $('#quick-create .options').addClass('hidden');
      if (!$(e.target).is('.actions')) {
        $('#menu').addClass('hidden');
        selected_task = null;
      }
      if ($(e.target).closest('#notifications-window, #notifications').length === 0) {
        return $('#notifications-window').addClass('hidden');
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
      return show_task_overlay(selected_task);
    });
    $('.sections a').on('click', function(e) {
      var classes;
      e.preventDefault();
      classes = $(this).attr('class');
      if (classes.indexOf('selected') < 0) {
        return show_task_detail_section(classes);
      }
    });
    $('#notifications').on('click', function(e) {
      e.preventDefault();
      if ($('.notification:not(.hidden)', '#notifications-window').length > 0) {
        return $('#notifications-window').toggleClass('hidden');
      }
    });
    $('#notifications-window .close').on('click', function(e) {
      e.preventDefault();
      $(this).parent().addClass('hidden');
      if ($(this).parent().siblings('.notification:not(.hidden)').length === 0) {
        return $('#notifications-window').addClass('hidden');
      }
    });
    $('#notifications-window .notification').on('click', function(e) {
      $(this).removeClass('unread');
      if ($('.unread', $(this).parent()).length === 0) {
        return $(this).parent().removeClass('top-unread');
      }
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
});
