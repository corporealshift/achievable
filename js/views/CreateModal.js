// Generated by CoffeeScript 1.7.1
define(['jquery', 'underscore', 'backbone', 'models/Tasks', 'models/Task', 'hbs!tpl/CreateModal'], function($, _, Backbone) {
  var Task, Tasks, tpl;
  Tasks = require('models/Tasks');
  Task = require('models/Task');
  tpl = require('hbs!tpl/CreateModal');
  return Backbone.View.extend({
    events: {
      "submit #create-task": "submit",
      "click": "close"
    },
    initialize: function(options) {
      this.setElement(tpl());
      this.modal = this.$('#create');
      this.form = this.$('#create-task');
      this.tasks = options.tasks;
      this.on("display", this.display_modal);
      return this.on("hide", this.hide_modal);
    },
    submit: function(e) {
      var form_data, form_elem, task, task_parts, _i, _len;
      e.preventDefault();
      form_data = this.form.serializeArray();
      task_parts = [];
      for (_i = 0, _len = form_data.length; _i < _len; _i++) {
        form_elem = form_data[_i];
        task_parts[form_elem.name] = form_elem.value;
      }
      task = new Task({
        "title": task_parts['title'],
        "description": task_parts['description'],
        "points": 10 + task_parts['difficulty'] * 2,
        "base_points": 10 + task_parts['difficulty'] * 2,
        chain: 20
      });
      if (task_parts['due_date'] !== "") {
        task.set("due_date", new Date(task_parts['due_date']));
      }
      this.tasks.add(task);
      return this.hide_modal();
    },
    display_modal: function(raw_task) {
      var title;
      this.$el.removeClass('hidden');
      title = raw_task.title;
      $('.title', this.form).val(title);
      if (title.length > 0) {
        return $('.due-date', this.form).focus();
      } else {
        return $('.title', this.form).focus();
      }
    },
    hide_modal: function() {
      return this.$el.addClass('hidden');
    },
    close: function(e) {
      if (e.target === this.el) {
        return this.$el.addClass('hidden');
      }
    }
  });
});
