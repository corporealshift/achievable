define(['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
    Backbone.Model.extend(
        defaults: ->
            created : new Date()
            modified: new Date()
            points  : 10
            base_points: 10
            chain   : 1

        chain_points: -> Math.floor(@get('chain') / 7)
    )
)
