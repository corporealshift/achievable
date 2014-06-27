define(['jquery', 'underscore', 'backbone', 'models/Task', 'hbs!tpl/Task'], ($, _, Backbone) ->
    tpl = require 'hbs!tpl/Task'

    Backbone.View.extend(
        initialize: (options) ->
            @model = options.task

            @listenTo @model, 'change', @render
            console.log "new task view with task data", @model.toJSON()

            model_data = @model.toJSON()
            if (@model.get('due_date')?)
                model_data = @_days_remaining(@model, model_data)

            model_data.chain_points = @model.chain_points()

            @setElement tpl model_data

            @hide_remaining() if !@model.get('due_date')?

            @menu = @$ '.menu'

        render: ->
            @

        # Task Events
        events:
            'click .actions'     : 'show_menu'
            'click .menu a'      : 'show_task_details'
            'click h4'           : 'show_task_details'
            'click .sections a'  : 'select_section'
            'mouseenter .menu a' : 'menu_hover'
            'mouseleave .menu a' : 'menu_hover'

        show_menu: (e) ->
            e.preventDefault()
            window.selected_task = @$el
            @menu.removeClass 'hidden'

        show_task_details: (e) ->
            e.preventDefault()
            @$el.addClass 'detailed'
            @hide_menu()
            @show_task_overlay()

        hide_menu: (e) ->
            @menu.addClass 'hidden'

        hide_remaining: -> @$el.find('.remaining').addClass 'hidden'

        show_remaining: -> @$el.find('.remaining').removeClass 'hidden'

        menu_hover: (e) -> $(e.target).toggleClass 'selected'

        show_task_overlay: ->
            $('.task-details').addClass 'hidden'
            $('body').addClass 'overlaid'
            @$el.find('.task-details').removeClass 'hidden'


        select_section: (e) ->
            e.preventDefault()
            classes = $(e.target).attr 'class'
            @show_task_detail_section(classes) if classes.indexOf('selected') < 0

        show_task_detail_section: (section) ->
            @$('.sections a').removeClass 'selected'
            @$('.sections .' + section).addClass 'selected'
            @$('.section').removeClass 'selected'
            @$('.section.' + section).toggleClass 'selected'

        _days_remaining: (model, model_data) ->
            days_remaining = Math.round((model.get('due_date') - new Date()) / (1000*60*60*24))

            model_data.days_remaining = days_remaining
            model_data.days_msg = "LATE" if days_remaining < 0
            model_data.days_msg = "Today" if days_remaining == 0
            model_data.days_msg = "1 Day" if days_remaining == 1
            model_data.days_msg = "#{days_remaining} Days" if days_remaining > 1
            model_data.days_msg = "Far" if days_remaining >= 100
            model_data.days_remaining = "future" if days_remaining >= 10

            model_data
    )
)
