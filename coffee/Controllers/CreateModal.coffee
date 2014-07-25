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

    $scope.$watch 'adv_create', (val) ->
        $scope.task.title = $scope.$parent.title if val

    $scope.reset()
