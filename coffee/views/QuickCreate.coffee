define(['jquery', 'underscore', 'backbone', 'models/Task'], ($, _, Backbone) ->
    Task = require 'models/Task'

    Backbone.View.extend(
        el: '#quick-create'

        events:
            "keyup input[type=text]": "show_create_options"
            "keydown input[type=text]": "stop_arrows"
            "submit": "submit"
            "click a": "option_selected"

        stop_arrows: (e) ->
            e.preventDefault() if (e.which == 40 || e.which == 38)

        show_create_options: (e) ->
            return true if (e.which == 91)
            text = @$('input[type=text]').val()
            dropdown = @$ '.options'

            console.log e.which

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
            # Will be event based soon
            window.show_create_modal() if (e.which == 13)

        submit: (e) ->
            @$('.options').addClass 'hidden'
            e.preventDefault()

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


        render: ->
            @$el.html(@template())
    )
)
