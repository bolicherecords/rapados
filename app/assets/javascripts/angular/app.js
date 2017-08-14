angular.module('RapadosApp', ['ui.router', 'rapadosControllers','ngMaterial'])
  .config(['$stateProvider', '$urlRouterProvider',function($stateProvider, $urlRouterProvider) { // provider-injector
    // $stateProvider.state('provider', {
    //      url: "/providers/{provider:json}",
    //      templateUrl: "/providers/show.haml",
    //      controller: function($scope, $stateParams) {
    //        return provider = $stateParams;
    //      }
    //  });
  }])

  // function AppCtrl($scope) {
  //   $scope.currentNavItem = 'page1';
  // }
