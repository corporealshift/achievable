quick_create_index = 0
$ ->
    # Quick create events
    $('#quick-create').on 'keyup', 'input[type=text]', (e) ->
        return true if (e.which == 91)
        text = $(this).val()
        dropdown = $ '#quick-create .options'
        if (text.length > 0)
            dropdown.removeClass 'hidden'
            $('#quick-create .user-value').text(text)
        dropdown.addClass('hidden') if (e.which == 27)

    $('#quick-create').on 'submit', (e) ->
        $('#create-overlay').removeClass 'hidden'
        $('#quick-create .options').addClass 'hidden'
        $('#create-overlay #create-task .title').val($('#quick-create input[type=text]').val())
        $('#create-overlay #create-task .due-date').focus()
        e.preventDefault()

    # Close menu/overlay events
    $('body').on 'click', (e) ->
        $('#quick-create .options').addClass 'hidden'

        if (!$(e.target).is('.actions'))
            $('#menu').addClass 'hidden'

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

        menu.removeClass 'hidden'
        menu.css
            top: e.pageY - 5
            left: e.pageX + 15

    # Show task details. This should happen when the user clicks "edit" in
    # the actions menu too
    $('.task h4').on 'click', (e) ->
        e.preventDefault();
        original_task = $(this).parent()
        new_task = original_task.clone()
        $('#overlay .selected-elem').html new_task
        $('#overlay .selected-elem').css original_task.offset()
        console.log original_task

        $('#overlay').removeClass 'hidden'

        # modal top should be 75px above the middle of the task
        $('.modal').css
            top: original_task.offset().top + (original_task[0].offsetHeight / 2) - 75
            left: original_task.offset().left + original_task[0].offsetWidth + 15

    $('.task').on 'dragstart dragend', (e) ->
        $('.task-actions').toggleClass 'invisible'

    $('.task-actions div').on 'dragenter', (e) ->
        console.log 'drug over action ' + $(this).text()
        $(this).siblings().addClass 'fade-out'

    $('.task-actions div').on 'dragleave', (e) ->
        $(this).siblings().removeClass 'fade-out'
