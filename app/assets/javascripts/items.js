var itemApp = angular.module('items_app', ['ngResource']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    //defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

itemApp.factory('Item', ['$http', function($http) {
  console.log("before returning resource");
  return $http({method: 'GET', url: 'http://search.3taps.com/?auth_token=a3d09bcb83580db63e9fd0cac1af5cac&rpp=100&retvals=external_id,category,heading,body,images,price,location,external_url&category=SFUR&radius=15mi&lat=34.05256&long=-118.44193&price=1000..&heading=("sofa")'});
  console.log("after returning resource");
}]);

itemApp.controller('ItemCtrl', ['$scope', 'Item', function($scope, Item) {
    $scope.items= [];
    console.log("in the controller");

     Item.success(function(data, status, headers, config) {
        $scope.items = data.postings;
        console.log("here are the items");
        console.log($scope.items);
      });
}])