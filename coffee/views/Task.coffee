define(['jquery', 'underscore', 'backbone', 'models/Task', 'hbs!tpl/Task'], ($, _, Backbone) ->
    tpl = require 'hbs!tpl/Task'
    Backbone.View.extend(
        initialize: (options) ->
            @model = options.task
            console.log "new task view with task data", @model.toJSON()

            @$el.html tpl @model.toJSON()
    )
)
