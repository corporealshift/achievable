app = angular.module('app', ['ngRoute'])

QuickCreate = ($scope) ->
    $scope.create = ->
        console.log "create new task"
        @$parent.tasks = [] unless @$parent.tasks?
        @$parent.tasks.push
            title: @title
            created: new Date()
            modified: new Date()
            description: ""
            points:
                total: 5
                base: 5
                motivation: 0
                chain: 0
            chain: 0
            motivation: 0
        @title = ""

    $scope.adv_create = ->
        console.log "adv create new task"
        @$parent.adv_create = true
        @title = ""


CreateTask = ($scope) ->
    $scope.master =
        description : ""
        difficulty  : 0
        created     : new Date()
        modified    : new Date()
        points      :
            base       : 5
            motivation : 0
            chain      : 0
            total      : 5
        chain       : 0
        motivation  : 0

    $scope.reset = -> $scope.task = angular.copy $scope.master

    $scope.add_task = ->
        @$parent.tasks    = [] unless @$parent.tasks?
        $scope.task.points.total = 5 + (2 * +$scope.task.difficulty)
        @$parent.tasks.push $scope.task

        @$parent.adv_create = false
        $scope.reset()

    $scope.reset()

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
