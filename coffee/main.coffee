require.config(
    baseUrl: 'js',
    paths:
        'jquery'     : 'components/jquery/dist/jquery.min',
        'underscore' : 'components/underscore/underscore',
        'backbone'   : 'components/backbone/backbone',
        'hbs'        : 'components/handlebars/hbs',
        'd3'         : 'components/d3/d3.min', # @todo make this AMD
        'nvd3'       : 'components/nvd3/nv.d3.min' # @todo make this AMD
)

require(['jquery',
        'underscore',
        'backbone',
        'd3',
        'nvd3',
        'views/Tasks',
        'models/Task',
        'models/Tasks',
        'views/QuickCreate',
        'views/CreateModal'], ($, _, Backbone) ->
    TaskArray   = require 'models/Tasks'
    Tasks       = require 'views/Tasks'
    Task        = require 'models/Task'
    QuickCreate = require 'views/QuickCreate'
    CreateTask  = require 'views/CreateModal'
    # d3          = require 'd3'
    # nv          = require 'nvd3'
    window.tasks = new TaskArray()

    tasks_view   = new Tasks
        tasks: window.tasks

    create_modal = new CreateTask
        tasks: window.tasks

    quick_create = new QuickCreate
        create_modal: create_modal
        tasks: window.tasks

    quick_create_index = 0
    window.selected_task = null

    window.show_task_overlay = (original_task) ->
        new_task = original_task.clone()

        new_task.find('.menu, .actions').remove()

        $('#overlay .selected-elem').html new_task
        $('#overlay .selected-elem').css original_task.offset()
        $('#overlay').removeClass 'hidden'

    show_task_detail_section = (section) ->
        $('.sections a').removeClass 'selected'
        $('.sections .' + section).addClass 'selected'
        $('.section').removeClass 'selected'
        $('.section.' + section).toggleClass 'selected'

    $ ->
        $('body').append create_modal.$el
        # Close menu/overlay events
        $('html').on 'click', (e) ->
            $('#quick-create .options').addClass 'hidden'

            if (!$(e.target).is('.actions'))
                $('.menu').addClass 'hidden'
                window.selected_task = null

            if ($(e.target).closest('#notifications-window, #notifications').length == 0)
                $('#notifications-window').addClass 'hidden'

        $('#overlay').on 'click', (e) ->
            if (e.target == this)
                $('#overlay').addClass 'hidden'

        $('.sections a').on 'click', (e) ->
            e.preventDefault()
            classes = $(this).attr 'class'
            show_task_detail_section(classes) if classes.indexOf('selected') < 0

        # Notifications Events
        $('#notifications').on 'click', (e) ->
            e.preventDefault();
            if ($('.notification:not(.hidden)', '#notifications-window').length > 0)
                $('#notifications-window').toggleClass 'hidden'

        $('#notifications-window .close').on 'click', (e) ->
            e.preventDefault();
            $(this).parent().addClass 'hidden'
            if ($(this).parent().siblings('.notification:not(.hidden)').length == 0)
                $('#notifications-window').addClass 'hidden'

        $('#notifications-window .notification').on 'click', (e) ->
            $(this).removeClass 'unread'
            if ($('.unread',$(this).parent()).length == 0)
                $(this).parent().removeClass 'top-unread'

        $('.tasks').on 'dragstart dragend', '.task', (e) ->
            $('.task-actions').toggleClass 'invisible'
            oe = e.originalEvent
            oe.dataTransfer.setDragImage(this, -10, -10)
            oe.dataTransfer.effectAllowed = 'move'
            oe.dataTransfer.setData('text/html', this.innerHTML)

        $('.tasks').on 'drop', '.task', (e) ->
            console.log "dropped" # not working

        $('.task-actions div').on 'dragenter', (e) ->
            console.log 'drug over action ' + $(this).text()
            $(this).siblings().addClass 'fade-out'

        $('.task-actions div').on 'dragleave', (e) ->
            $(this).siblings().removeClass 'fade-out'


        # CHARTS
        nv.addGraph( ->
            data = [{
                label : "Complete"
                value : 7
            },{
                label : "Incomplete"
                value : 5
            }]
            chart = nv.models.pieChart()
              .x((d) -> d.label + " (" + d.value + ")")
              .y((d) -> d.value)
              .showLabels(true)

            d3.select("#completed svg")
                .datum(data)
                .transition().duration(1200)
                .call(chart)

            nv.utils.windowResize chart.update
            chart
        )

        nv.addGraph( ->
            chart = nv.models.multiBarChart()
            data = [{
                key    : "Complete"
                values : [{x: new Date("2014-06-15"), y: 2}, {x: new Date("2014-06-22"), y: 3}]
                color  : "Lightgreen"
            },{
                key    : "Incomplete"
                values : [{x: new Date("2014-06-15"), y: 1}, {x: new Date("2014-06-22"), y: 4}]
                color  : "Orange"
            }]

            chart.xAxis
                .tickFormat(d3.time.format('%x'))

            chart.yAxis
                .tickFormat(d3.format(',f'))

            chart.multibar.stacked true
            chart.showControls false

            d3.select('#weekly svg').datum(data)
                .transition().duration(500)
                .call(chart)

            nv.utils.windowResize chart.update

            chart
        )
)
