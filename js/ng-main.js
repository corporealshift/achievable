// Generated by CoffeeScript 1.7.1
var CreateTask, QuickCreate, TasksController, app;

app = angular.module('app', ['ngRoute']);

QuickCreate = function($scope) {
  $scope.create = function() {
    console.log("create new task");
    if (this.$parent.tasks == null) {
      this.$parent.tasks = [];
    }
    this.$parent.tasks.push({
      title: this.title,
      created: new Date(),
      modified: new Date(),
      description: "",
      points: {
        total: 5,
        base: 5,
        motivation: 0,
        chain: 0
      },
      chain: 0,
      motivation: 0
    });
    return this.title = "";
  };
  return $scope.adv_create = function() {
    console.log("adv create new task");
    this.$parent.adv_create = true;
    return this.title = "";
  };
};

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
  return $scope.reset();
};

TasksController = function($scope) {
  $scope.short_description = function() {
    if (this.task.description.length < 75) {
      return this.task.description;
    } else {
      return this.task.description.substr(0, 75) + "...";
    }
  };
  $scope.days_msg = function() {
    var days_msg, days_remaining;
    days_remaining = this.days_remaining();
    if (days_remaining < 0) {
      days_msg = "LATE";
    }
    if (days_remaining === 0) {
      days_msg = "Today";
    }
    if (days_remaining === 1) {
      days_msg = "1 Day";
    }
    if (days_remaining > 1) {
      days_msg = "" + days_remaining + " Days";
    }
    if (days_remaining >= 100) {
      days_msg = "Far";
    }
    return days_msg;
  };
  $scope.days_remaining = function() {
    var remaining;
    remaining = Math.round((this.task.due_date - new Date()) / (1000 * 60 * 60 * 24));
    if (remaining >= 10) {
      remaining = "future";
    }
    if (remaining < 0) {
      remaining = -1;
    }
    return remaining;
  };
  $scope.due_date = function() {
    if (this.task.due_date != null) {
      return this.date(this.task.due_date);
    }
  };
  $scope.created = function() {
    return this.date(this.task.created);
  };
  $scope.modified = function() {
    return this.date(this.task.modified);
  };
  $scope.date = function(date) {
    return [date.getFullYear(), this.pad(date.getMonth() + 1), this.pad(date.getDate())].join('/');
  };
  return $scope.pad = function(val) {
    if (val < 10) {
      return "0" + val;
    } else {
      return val;
    }
  };
};
