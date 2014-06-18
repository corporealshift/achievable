define(['jquery', 'underscore', 'backbone', 'models/Task', 'hbs!tpl/Task'], ($, _, Backbone) ->
    tpl = require 'hbs!tpl/Task'

    Backbone.View.extend(
        initialize: (options) ->
            @model = options.task
            console.log "new task view with task data", @model.toJSON()

            model_data = @model.toJSON()
            if (@model.get('due_date')?)
                days_remaining = Math.round((@model.get('due_date') - new Date()) / (1000*60*60*24))

                model_data.days_remaining = days_remaining
                model_data.days_msg = "LATE" if days_remaining < 0
                model_data.days_msg = "Today" if days_remaining == 0
                model_data.days_msg = "1 Day" if days_remaining == 1
                model_data.days_msg = "#{days_remaining} Days" if days_remaining > 1
                model_data.days_msg = "Far" if days_remaining >= 100
                model_data.days_remaining = "future" if days_remaining >= 10


            @setElement tpl model_data

            @menu = @$ '.menu'

        # Task Events
        events:
            'click .actions' : 'show_menu'
            'click .menu a'  : 'show_task_details'
            'click h4'       : 'show_task_details'
            'mouseenter .menu a' : 'menu_hover'
            'mouseleave .menu a' : 'menu_hover'

        show_menu: (e) ->
            e.preventDefault()
            window.selected_task = @$el
            @menu.removeClass 'hidden'

        show_task_details: (e) ->
            e.preventDefault()
            @hide_menu()
            window.show_task_overlay @$el

        hide_menu: (e) ->
            @menu.addClass 'hidden'

        menu_hover: (e) -> $(e.target).toggleClass 'selected'
    )
)
