define(['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
    Backbone.Model.extend(
        defaults: ->
            created : new Date()
            points  : 10
            chain   : 1
    )
)
