require.config(
    baseUrl: 'js',
    paths:
        'jquery'     : 'components/jquery/dist/jquery.min',
        'underscore' : 'components/underscore/underscore',
        'backbone'   : 'components/backbone/backbone'
)

require(['jquery', 'underscore', 'backbone', 'models/Task', 'views/QuickCreate'], ($, _, Backbone) ->
    Task = require 'models/Task'
    QuickCreate = require 'views/QuickCreate'

    quick_create = new QuickCreate()
    task = new Task()
    task.set 'title', 'test task'
    console.log task

    quick_create_index = 0
    selected_task = null

    window.show_create_modal = ->
        $('#create-overlay').removeClass 'hidden'
        title = $('#quick-create input[type=text]').val()
        $('#create-overlay #create-task .title').val(title)
        if (title.length > 0)
            $('#create-overlay #create-task .due-date').focus()
        else
            $('#create-overlay #create-task .title').focus()

    show_task_overlay = (original_task) ->
        new_task = original_task.clone()
        $('#overlay .selected-elem').html new_task
        $('#overlay .selected-elem').css original_task.offset()
        console.log original_task

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

        console.log "doc ready"

        # Close menu/overlay events
        $('html').on 'click', (e) ->
            $('#quick-create .options').addClass 'hidden'

            if (!$(e.target).is('.actions'))
                $('#menu').addClass 'hidden'
                selected_task = null

            if ($(e.target).closest('#notifications-window, #notifications').length == 0)
                $('#notifications-window').addClass 'hidden'

        $('#overlay').on 'click', (e) ->
            if (e.target == this)
                $('#overlay').addClass 'hidden'

        $('#create-overlay').on 'click', (e) ->
            if (e.target == this)
                $('#create-overlay').addClass 'hidden'


        # Task Events
        $('.actions').on 'click', (e) ->
            menu = $('#menu')
            e.preventDefault()
            selected_task = $(this).parent()
            menu.removeClass 'hidden'
            menu.css
                top: e.pageY - 5
                left: e.pageX + 15

        $('#menu').on 'click', 'a', (e) ->
            e.preventDefault()
            show_task_overlay(selected_task)

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


        # Show task details. This should happen when the user clicks "edit" in
        # the actions menu too
        $('.task h4').on 'click', (e) ->
            e.preventDefault();
            show_task_overlay($(this).parent())

        $('.task').on 'dragstart dragend', (e) ->
            $('.task-actions').toggleClass 'invisible'

        $('.task-actions div').on 'dragenter', (e) ->
            console.log 'drug over action ' + $(this).text()
            $(this).siblings().addClass 'fade-out'

        $('.task-actions div').on 'dragleave', (e) ->
            $(this).siblings().removeClass 'fade-out'
)
