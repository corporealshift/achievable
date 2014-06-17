// Generated by CoffeeScript 1.7.1
define(['jquery', 'underscore', 'backbone', 'models/Task', 'hbs!tpl/Task'], function($, _, Backbone) {
  var tpl;
  tpl = require('hbs!tpl/Task');
  return Backbone.View.extend({
    initialize: function(options) {
      this.model = options.task;
      console.log("new task view with task data", this.model.toJSON());
      return this.$el.html(tpl(this.model.toJSON()));
    }
  });
});
