define(['jquery', 'underscore', 'backbone', 'models/Task'], ($, _, Backbone) ->
    Backbone.View.extend(
        el: '#task-tpl'
        initialize: (options) ->
            @model = options.task
            console.log "new task view with task", @model
    )
)
