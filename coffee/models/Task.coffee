define(['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
    Backbone.Model.extend(
        defaults: ->
            due_date: new Date()
            created: new Date()
    )
)
