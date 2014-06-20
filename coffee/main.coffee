require.config(
    baseUrl: 'js',
    paths:
        'jquery'     : 'components/jquery/dist/jquery.min',
        'underscore' : 'components/underscore/underscore',
        'backbone'   : 'components/backbone/backbone',
        'hbs'        : 'components/handlebars/hbs'
)

require(['jquery',
        'underscore',
        'backbone',
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
    window.tasks = new TaskArray()

    tasks_view   = new Tasks
        tasks: window.tasks

    create_modal = new CreateTask()
    quick_create = new QuickCreate
        create_modal: create_modal

    quick_create_index = 0
    window.selected_task = null

    window.show_task_overlay = (original_task) ->
        new_task = original_task.clone()

        new_task.find('.menu, .actions').remove()

        $('#overlay .selected-elem').html new_task
        $('#overlay .selected-elem').css original_task.offset()
        $('#overlay').removeClass 'hidden'

        # modal top should be 75px above the middle of the task
        $('.modal').css
            top: original_task.offset().top + (original_task[0].offsetHeight / 2) - 75
            left: original_task.offset().left + original_task[0].offsetWidth + 15

    show_task_detail_section = (section) ->
        $('.sections a').removeClass 'selected'
        $('.sections .' + section).addClass 'selected'
        $('.section').removeClass 'selected'
        $('.section.' + section).toggleClass 'selected'

    $ ->
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

        $('#create-overlay').on 'click', (e) ->
            if (e.target == this)
                $('#create-overlay').addClass 'hidden'

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
)
