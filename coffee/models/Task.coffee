define(['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
    Backbone.Model.extend(
        defaults: ->
            created : new Date()
            modified: new Date()
            description: ""
            points  :
                base       : 10
                chain      : 0
                motivation : 0
                total      : 10
            chain   : 1

        chain_points: -> Math.floor(@get('chain') / 7)

        short_description: -> if @get('description').length < 75 then @get 'description' else @get('description').substr(0, 75) + "..."

        toJSON: ->
            title             : @get 'title'
            description       : @get 'description'
            chain             : @get 'chain'
            short_description : @short_description()
            days_msg          : @_days_rem_msg()
            days_remaining    : @_days_remaining()
            due_date          : if @get('due_date')? then @_date_format @get('due_date') else ""
            created           : @_date_format @get('created')
            modified          : @_date_format @get('modified')
            points            : @get 'points'


        _date_format: (date) -> [date.getFullYear(), @_pad(date.getMonth() + 1), @_pad(date.getDate())].join('/')

        _pad: (val) -> if val < 10 then "0#{val}" else val

        _days_remaining: ->
            remaining = Math.round((@get('due_date') - new Date()) / (1000*60*60*24))
            remaining = "future" if remaining >= 10
            remaining

        _days_rem_msg: ->
            days_remaining = @_days_remaining()

            days_msg = "LATE" if days_remaining < 0
            days_msg = "Today" if days_remaining == 0
            days_msg = "1 Day" if days_remaining == 1
            days_msg = "#{days_remaining} Days" if days_remaining > 1
            days_msg = "Far" if days_remaining >= 100

            days_msg
    )
)
