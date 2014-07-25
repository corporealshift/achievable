QuickCreate = ($scope) ->
    $scope.create = ->
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
        @$parent.title = @title
        @title = ""
