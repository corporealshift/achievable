define(['jquery', 'underscore', 'backbone', 'models/Tasks', 'models/Task'], ($, _, Backbone) ->
    Tasks = require 'models/Tasks'
    Task  = require 'models/Task'

    Backbone.View.extend(
        el: '#quick-create'

        events:
            "keyup input[type=text]"   : "show_create_options"
            "keydown input[type=text]" : "stop_arrows"
            "submit"                   : "submit"
            "click a"                  : "option_selected"
            "mouseover .options a"     : "hover_option"
            "click a.create"           : "quick_create"

        stop_arrows: (e) ->
            e.preventDefault() if (e.which == 40 or e.which == 38)

        show_create_options: (e) ->
            return true if (e.which == 91)
            text = @$('input[type=text]').val()
            dropdown = @$ '.options'

            if (text.length > 0)
                dropdown.removeClass 'hidden'
                @$('.user-value').text text
                if (e.which == 40)
                    e.preventDefault()
                    @select_next_option()
                else if (e.which == 38)
                    e.preventDefault()
                    @select_prev_option()

            dropdown.addClass('hidden') if (e.which == 27)

        submit: (e) ->
            e.preventDefault()
            @$('.options').addClass 'hidden'
            @quick_create()

        quick_create: ->
            title = @$('input[type=text]').val()
            window.tasks ?= new Tasks()
            window.tasks.add(new Task({title: title}))

        option_selected: (e) ->
            e.preventDefault();
            if ($(e.target).is('.create-with-options'))
                window.show_create_modal()

        select_next_option: ->
            @select_option ((opt) -> opt.first()), ((sel) -> sel.next())

        select_prev_option: ->
            @select_option ((opt) -> opt.last()), ((sel) -> sel.prev())

        select_option: (blank, step) ->
            options  = @$ '.options a'
            selected = @$ '.options a.selected'

            if (selected.length == 0)
                selected = blank(options).addClass 'selected'
            else
                selected.removeClass 'selected'
                step(selected).addClass 'selected'

        hover_option: (e) ->
            @$('.options .selected').removeClass 'selected'
            @$(e.currentTarget).addClass 'selected'
    )
)
