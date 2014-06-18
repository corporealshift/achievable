// Generated by CoffeeScript 1.7.1
define(['jquery', 'underscore', 'backbone', 'models/Task', 'hbs!tpl/Task'], function($, _, Backbone) {
  var tpl;
  tpl = require('hbs!tpl/Task');
  return Backbone.View.extend({
    initialize: function(options) {
      var model_data;
      this.model = options.task;
      console.log("new task view with task data", this.model.toJSON());
      model_data = this.model.toJSON();
      this.setElement(tpl(model_data));
      return this.menu = this.$('.menu');
    },
    events: {
      'click .actions': 'show_menu',
      'click .menu a': 'show_task_details',
      'click h4': 'show_task_details',
      'mouseenter .menu a': 'menu_hover',
      'mouseleave .menu a': 'menu_hover'
    },
    show_menu: function(e) {
      e.preventDefault();
      window.selected_task = this.$el;
      return this.menu.removeClass('hidden');
    },
    show_task_details: function(e) {
      e.preventDefault();
      this.hide_menu();
      return window.show_task_overlay(this.$el);
    },
    hide_menu: function(e) {
      return this.menu.addClass('hidden');
    },
    menu_hover: function(e) {
      return $(e.target).toggleClass('selected');
    }
  });
});
