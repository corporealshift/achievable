// Generated by CoffeeScript 1.7.1
define(['jquery', 'underscore', 'backbone', 'models/Tasks', 'models/Task'], function($, _, Backbone) {
  var Task, Tasks;
  Tasks = require('models/Tasks');
  Task = require('models/Task');
  return Backbone.View.extend({
    el: '#quick-create',
    events: {
      "keyup input[type=text]": "show_create_options",
      "keydown input[type=text]": "stop_arrows",
      "submit": "submit",
      "click a": "option_selected",
      "mouseover .options a": "hover_option",
      "click a.create": "quick_create"
    },
    initialize: function(options) {
      this.create_modal = options.create_modal;
      return this.tasks = options.tasks;
    },
    stop_arrows: function(e) {
      if (e.which === 40 || e.which === 38) {
        return e.preventDefault();
      }
    },
    show_create_options: function(e) {
      var dropdown, text;
      if (e.which === 91) {
        return true;
      }
      text = this.$('input[type=text]').val();
      dropdown = this.$('.options');
      if (text.length > 0) {
        dropdown.removeClass('hidden');
        this.$('.user-value').text(text);
        if (e.which === 40) {
          e.preventDefault();
          this.select_next_option();
        } else if (e.which === 38) {
          e.preventDefault();
          this.select_prev_option();
        }
      }
      if (e.which === 27) {
        return dropdown.addClass('hidden');
      }
    },
    submit: function(e) {
      e.preventDefault();
      this.$('.options').addClass('hidden');
      return this.quick_create();
    },
    quick_create: function() {
      var title;
      title = this.$('input[type=text]').val();
      this.tasks.add(new Task({
        title: title
      }));
      return this.$('input[type=text]').val('');
    },
    option_selected: function(e) {
      e.preventDefault();
      if ($(e.target).is('.create-with-options') || $(e.target).parent().is('.create-with-options')) {
        return this.create_modal.trigger('display', {
          title: this.$('input[type=text]').val()
        });
      }
    },
    select_next_option: function() {
      return this.select_option((function(opt) {
        return opt.first();
      }), (function(sel) {
        return sel.next();
      }));
    },
    select_prev_option: function() {
      return this.select_option((function(opt) {
        return opt.last();
      }), (function(sel) {
        return sel.prev();
      }));
    },
    select_option: function(blank, step) {
      var options, selected;
      options = this.$('.options a');
      selected = this.$('.options a.selected');
      if (selected.length === 0) {
        return selected = blank(options).addClass('selected');
      } else {
        selected.removeClass('selected');
        return step(selected).addClass('selected');
      }
    },
    hover_option: function(e) {
      this.$('.options .selected').removeClass('selected');
      return this.$(e.currentTarget).addClass('selected');
    }
  });
});
