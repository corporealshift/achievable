// Generated by CoffeeScript 1.7.1
require.config({
  baseUrl: 'js',
  paths: {
    'jquery': 'components/jquery/dist/jquery.min',
    'underscore': 'components/underscore/underscore',
    'backbone': 'components/backbone/backbone',
    'hbs': 'components/handlebars/hbs',
    'd3': 'components/d3/d3.min',
    'nvd3': 'components/nvd3/nv.d3.min'
  }
});

require(['jquery', 'underscore', 'backbone', 'd3', 'nvd3', 'views/Tasks', 'models/Task', 'models/Tasks', 'views/QuickCreate', 'views/CreateModal'], function($, _, Backbone) {
  var CreateTask, QuickCreate, Task, TaskArray, Tasks, create_modal, quick_create, quick_create_index, show_task_detail_section, tasks_view;
  TaskArray = require('models/Tasks');
  Tasks = require('views/Tasks');
  Task = require('models/Task');
  QuickCreate = require('views/QuickCreate');
  CreateTask = require('views/CreateModal');
  window.tasks = new TaskArray();
  tasks_view = new Tasks({
    tasks: window.tasks
  });
  create_modal = new CreateTask();
  quick_create = new QuickCreate({
    create_modal: create_modal
  });
  quick_create_index = 0;
  window.selected_task = null;
  window.show_task_overlay = function(original_task) {
    var new_task;
    new_task = original_task.clone();
    new_task.find('.menu, .actions').remove();
    $('#overlay .selected-elem').html(new_task);
    $('#overlay .selected-elem').css(original_task.offset());
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
    $('html').on('click', function(e) {
      $('#quick-create .options').addClass('hidden');
      if (!$(e.target).is('.actions')) {
        $('.menu').addClass('hidden');
        window.selected_task = null;
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
    $('.tasks').on('dragstart dragend', '.task', function(e) {
      var oe;
      $('.task-actions').toggleClass('invisible');
      oe = e.originalEvent;
      oe.dataTransfer.setDragImage(this, -10, -10);
      oe.dataTransfer.effectAllowed = 'move';
      return oe.dataTransfer.setData('text/html', this.innerHTML);
    });
    $('.tasks').on('drop', '.task', function(e) {
      return console.log("dropped");
    });
    $('.task-actions div').on('dragenter', function(e) {
      console.log('drug over action ' + $(this).text());
      return $(this).siblings().addClass('fade-out');
    });
    $('.task-actions div').on('dragleave', function(e) {
      return $(this).siblings().removeClass('fade-out');
    });
    nv.addGraph(function() {
      var chart, data;
      data = [
        {
          label: "Complete",
          value: 7
        }, {
          label: "Incomplete",
          value: 5
        }
      ];
      chart = nv.models.pieChart().x(function(d) {
        return d.label + " (" + d.value + ")";
      }).y(function(d) {
        return d.value;
      }).showLabels(true);
      d3.select("#completed svg").datum(data).transition().duration(1200).call(chart);
      nv.utils.windowResize(chart.update);
      return chart;
    });
    return nv.addGraph(function() {
      var chart, data;
      chart = nv.models.multiBarChart();
      data = [
        {
          key: "Complete",
          values: [
            {
              x: new Date("2014-06-15"),
              y: 2
            }, {
              x: new Date("2014-06-22"),
              y: 3
            }
          ],
          color: "Lightgreen"
        }, {
          key: "Incomplete",
          values: [
            {
              x: new Date("2014-06-15"),
              y: 1
            }, {
              x: new Date("2014-06-22"),
              y: 4
            }
          ],
          color: "Orange"
        }
      ];
      chart.xAxis.tickFormat(d3.time.format('%x'));
      chart.yAxis.tickFormat(d3.format(',f'));
      chart.multibar.stacked(true);
      chart.showControls(false);
      d3.select('#weekly svg').datum(data).transition().duration(500).call(chart);
      nv.utils.windowResize(chart.update);
      return chart;
    });
  });
});
