QuickCreate = ($scope) ->
    $scope.create = ->
        console.log "create new task"

    $scope.adv_create = ->
        console.log "adv create new task"
        this.$parent.adv_create = true
