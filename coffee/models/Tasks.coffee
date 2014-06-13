define(['jquery', 'underscore', 'backbone', 'models/Task'], ($, _, Backbone) ->
    Task = require 'models/Task'
    Backbone.Collection.extend(
         model: Task
    )
)
