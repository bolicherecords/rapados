var tetrapp =
angular.module('Tetrapp', ['ui.router', 'tetraControllers','ngMaterial'])
  .config(['$stateProvider', '$urlRouterProvider',function($stateProvider, $urlRouterProvider) { // provider-injector
    $stateProvider.state('example', {
         url: "/example",
         templateUrl: "/example"
     });
  }])
  function AppCtrl($scope) {
    $scope.currentNavItem = 'page1';
  }
