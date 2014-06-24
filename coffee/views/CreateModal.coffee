define(['jquery', 'underscore', 'backbone', 'models/Tasks', 'models/Task', 'hbs!tpl/CreateModal'], ($, _, Backbone) ->
    Tasks = require 'models/Tasks'
    Task  = require 'models/Task'
    tpl   = require 'hbs!tpl/CreateModal'

    Backbone.View.extend(

        events:
            "submit #create-task" : "submit"
            "click"      : "close"

        initialize: (options) ->
            @setElement tpl()
            @modal = @$ '#create'
            @form  = @$ '#create-task'
            @tasks = options.tasks
            @on "display", @display_modal
            @on "hide", @hide_modal

        submit: (e) ->
            e.preventDefault()
            form_data = @form.serializeArray()
            task_parts = []

            # transpose form data array into useful data
            task_parts[form_elem.name] = form_elem.value for form_elem in form_data

            # Save a new Task into the Tasks array
            @tasks.add new Task
                "title"       : task_parts['title']
                "due_date"    : new Date(task_parts['due_date'])
                "description" : task_parts['description']
                "points"      : 10 + task_parts['difficulty'] * 2
            # Close the task create window
            @hide_modal()

        display_modal: (raw_task) ->
            @$el.removeClass 'hidden'
            title = raw_task.title
            $('.title', @form).val title

            if (title.length > 0)
                $('.due-date', @form).focus()
            else
                $('.title', @form).focus()

        hide_modal: ->
            @$el.addClass 'hidden'

        close: (e) ->
            @$el.addClass 'hidden' if (e.target == @el)
    )
)
