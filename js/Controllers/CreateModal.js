// Generated by CoffeeScript 1.7.1
var CreateTask;

CreateTask = function($scope) {
  $scope.master = {
    description: "",
    difficulty: 0,
    created: new Date(),
    modified: new Date(),
    points: {
      base: 5,
      motivation: 0,
      chain: 0,
      total: 5
    },
    chain: 0,
    motivation: 0
  };
  $scope.reset = function() {
    return $scope.task = angular.copy($scope.master);
  };
  $scope.add_task = function() {
    if (this.$parent.tasks == null) {
      this.$parent.tasks = [];
    }
    $scope.task.points.total = 5 + (2 * +$scope.task.difficulty);
    this.$parent.tasks.push($scope.task);
    this.$parent.adv_create = false;
    return $scope.reset();
  };
  $scope.$watch('adv_create', function(val) {
    if (val) {
      return $scope.task.title = $scope.$parent.title;
    }
  });
  return $scope.reset();
};
