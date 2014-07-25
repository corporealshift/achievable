TasksController = ($scope) ->
    $scope.sections = [
        icon: 'D'
        name: 'details'
    ,
        icon: 'P'
        name: 'points'
    ]
    $scope.short_description = -> if @task.description.length < 75 then @task.description else @task.description.substr(0, 75) + "..."

    $scope.days_msg = ->
        days_remaining = @days_remaining()

        days_msg = "LATE"  if days_remaining < 0
        days_msg = "Today" if days_remaining == 0
        days_msg = "1 Day" if days_remaining == 1
        days_msg = "#{days_remaining} Days" if days_remaining > 1
        days_msg = "Far"   if days_remaining >= 100

        days_msg

    $scope.days_remaining = ->
        remaining = Math.round((@task.due_date - new Date()) / (1000*60*60*24))
        remaining = "future" if remaining >= 10
        remaining = -1 if remaining < 0
        remaining

    $scope.due_date = -> @date @task.due_date if @task.due_date?
    $scope.created  = -> @date @task.created
    $scope.modified = -> @date @task.modified

    $scope.date = (date) -> [date.getFullYear(), @pad(date.getMonth() + 1), @pad(date.getDate())].join('/')

    $scope.pad = (val) -> if val < 10 then "0#{val}" else val
