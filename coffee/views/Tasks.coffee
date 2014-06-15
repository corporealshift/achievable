define(['jquery', 'underscore', 'backbone', 'views/Task'], ($, _, Backbone) ->
    Task = require 'views/Task'
    console.log Task
    Backbone.View.extend (
        el: '#tasks'
        initialize: (options) ->
            @tasks = options.tasks
            @listenTo @tasks, 'add', @add_task

        add_task: (task) ->
            console.log "task added", task
            @$el.append((new Task task: task).$el)
    )
)
