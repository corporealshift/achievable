app = angular.module('app', ['ngRoute'])

QuickCreate = ($scope) ->
    $scope.create = ->
        console.log "create new task"

    $scope.adv_create = ->
        console.log "adv create new task"
        this.$parent.adv_create = true


CreateTask = ($scope) ->
    $scope.add_task = ->
        this.$parent.tasks = [] if !this.$parent.tasks?
        $scope.difficulty = 0 if !$scope.difficulty?
        this.$parent.tasks.push
            title: $scope.title
            due_date: $scope.due_date
            description: $scope.description
            points: 5 + (2 * +$scope.difficulty)
            chain: 1

        this.$parent.adv_create = false
