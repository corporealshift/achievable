define(['jquery', 'underscore', 'backbone', 'js/Task'], ($, _, Backbone) ->
    Task = require 'js/Task'
    Backbone.Collection.extend(
         model: Task,
         localStorage: new Backbone.LocalStorage("achievable"),
    )
)
