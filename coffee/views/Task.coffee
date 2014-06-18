define(['jquery', 'underscore', 'backbone', 'models/Task', 'hbs!tpl/Task'], ($, _, Backbone) ->
    tpl = require 'hbs!tpl/Task'

    Backbone.View.extend(
        initialize: (options) ->
            @model = options.task
            console.log "new task view with task data", @model.toJSON()

            model_data = @model.toJSON()

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
