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
            task_parts = []

            # transpose form data array into useful data
            task_parts[form_elem.name] = form_elem.value for form_elem in form_data

            # Save a new Task into the Tasks array
            window.tasks.add new Task
                "title"       : task_parts['title']
                "due_date"    : task_parts['due_date']
                "description" : task_parts['description']
            # Close the task create window
    )
)
