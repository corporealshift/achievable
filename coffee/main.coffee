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
            
                