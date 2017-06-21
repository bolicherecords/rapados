angular.module('RapadosApp', ['ui.router', 'rapadosControllers','ngMaterial'])
  .config(['$stateProvider', '$urlRouterProvider',function($stateProvider, $urlRouterProvider) { // provider-injector
    $stateProvider.state('example', {
         url: "/example",
         templateUrl: "/example"
     });
  }])
  function AppCtrl($scope) {
    $scope.currentNavItem = 'page1';
  }
