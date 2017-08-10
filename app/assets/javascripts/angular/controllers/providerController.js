controllers.controller('ProviderController', ['$scope', '$http', '$state', '$window', function($scope, $http, $state, $window){
	
	$scope.providers = [];

	$scope.getProviders = function(providers){
		for (var i=0; i<providers.length; i++){
			$scope.providers.push(providers[i]);
		}
	};

}]);