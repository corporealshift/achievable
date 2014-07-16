app = angular.module('app', ['ngRoute'])

QuickCreate = ($scope) ->
    $scope.create = ->
        console.log "create new task"

    $scope.adv_create = ->
        console.log "adv create new task"
        this.$parent.adv_create = true


CreateTask = ($scope) ->
    $scope.add_task = ->
        @$parent.tasks = [] unless @$parent.tasks?
        $scope.difficulty = 0 unless $scope.difficulty?
        @$parent.tasks.push
            title: $scope.title
            due_date: $scope.due_date
            created: new Date()
            modified: new Date()
            description: $scope.description || ""
            points:
                total: 5 + (2 * +$scope.difficulty)
                base: 5
                motivation: 0
                chain: 0
            chain: 1
            motivation: 0

        this.$parent.adv_create = false

TasksController = ($scope) ->

    $scope.short_description = -> if @task.description.length < 75 then @task.description else @task.description.substr(0, 75) + "..."

    $scope.days_msg = ->
        days_remaining = @days_remaining()

        days_msg = "LATE" if days_remaining < 0
        days_msg = "Today" if days_remaining == 0
        days_msg = "1 Day" if days_remaining == 1
        days_msg = "#{days_remaining} Days" if days_remaining > 1
        days_msg = "Far" if days_remaining >= 100

        days_msg

    $scope.days_remaining = ->
        remaining = Math.round((@task.due_date - new Date()) / (1000*60*60*24))
        remaining = "future" if remaining >= 10
        remaining


    _date_format: (date) -> [date.getFullYear(), @_pad(date.getMonth() + 1), @_pad(date.getDate())].join('/')

    _pad: (val) -> if val < 10 then "0#{val}" else val
