define(['jquery', 'underscore', 'backbone', 'models/Tasks', 'models/Task'], ($, _, Backbone) ->
    Tasks = require 'models/Tasks'
    Task = require 'models/Task'

    Backbone.View.extend(
        el: "#create-overlay"

        events:
            "submit #create-task" : "submit"

        initialize: ->
            @modal = @$ '#create'
            @form  = @$ '#create-task'
            window.tasks ?= new Tasks

        submit: (e) ->
            e.preventDefault()
            form_data = @form.serializeArray()
            # transpose form data array into useful data
            # Save a new Task into the Tasks array
            window.tasks.add new Task "title" : form_data[0].value
            # Close the task create window
    )
)
