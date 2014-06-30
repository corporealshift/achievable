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

            task = new Task
                title       : task_parts['title']
                description : task_parts['description']
                points      :
                    base       : 10 + task_parts['difficulty'] * 2
                    total      : 10 + task_parts['difficulty'] * 2
                    motivation : 0
                    chain      : 0
            # Save a new Task into the Tasks array
            if (task_parts['due_date'] != "")
                offset = new Date().getTimezoneOffset() / 60
                datestring = task_parts['due_date'] + "T00:00:00-0#{offset}00"
                task.set "due_date", new Date(datestring)

            @tasks.add task

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
