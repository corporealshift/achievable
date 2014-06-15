define(['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
    Backbone.View.extend (
        initialize: (options) ->
            @tasks = options.tasks
            @listenTo @tasks, 'add', ->
                console.log "task added"
    )
)
