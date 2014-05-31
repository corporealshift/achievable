quick_create_index = 0
$ ->
    $('#quick-create').on 'keyup', 'input[type=text]', (e) ->
        return true if (e.which == 91)
        console.log "keypress", e
        text = $(this).val()
        dropdown = $ '#quick-create .options'
        if (text.length > 0)
            dropdown.removeClass 'hidden'
            $('#quick-create .user-value').text(text)
        dropdown.addClass('hidden') if (e.which == 27)

    $('#quick-create').on 'submit', (e) ->
        e.preventDefault()

    $('body').on 'click', (e) ->
        $('#quick-create .options').addClass 'hidden'

        if (!$(e.target).is('.actions'))
            $('#menu').addClass 'hidden'

    $('.actions').on 'click', (e) ->
        menu = $('#menu')
        e.preventDefault()

        menu.removeClass 'hidden'
        menu.css
            top: e.pageY - 5
            left: e.pageX + 15

    $('.task').on 'dragstart dragend', (e) ->
        $('.task-actions').toggleClass 'invisible'

    $('.task-actions div').on 'dragenter', (e) ->
        console.log 'drug over action ' + $(this).text()
        $(this).siblings().addClass 'fade-out'

    $('.task-actions div').on 'dragleave', (e) ->
        $(this).siblings().removeClass 'fade-out'
