var itemApp = angular.module('items_app', ['ngResource']).config(
    ['$httpProvider', function($httpProvider) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");
    var defaults = $httpProvider.defaults.headers;

    // defaults.common["X-CSRF-TOKEN"] = authToken;
    defaults.patch = defaults.patch || {};
    defaults.patch['Content-Type'] = 'application/json';
    defaults.common['Accept'] = 'application/json';
}]);

itemApp.factory('Item', ['$http', function($http) {
  console.log("before returning resource");
  return $http({method: 'GET', url: 'http://search.3taps.com/?auth_token=a3d09bcb83580db63e9fd0cac1af5cac&rpp=100&retvals=external_id,category,heading,body,images,price,location,external_url&category=SFUR&heading=("sofa"))'});
  console.log("after returning resource");
}]);

// wrapper around call to $resource, which calls the API
itemApp.factory('Favorite', ['$resource', function($resource) {
  return $resource('/favorites/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);


itemApp.controller('ItemCtrl', ['$scope', 'Item', 'Favorite', function($scope, Item, Favorite) {
    $scope.items= [];
    $scope.favorites = [];

    Item.success(function(data, status, headers, config) {
      $scope.items = data.postings;
    });

    

    $scope.addFavorite = function(item) {
      console.log(item);
      $scope.newFavorite = new Favorite({favorite: {
        external_id: item.external_id,
        external_url: item.external_url,
        image_url: item.images[0].full
      }});

      console.log($scope.newFavorite);

      $scope.newFavorite.$save(function(item) {
        // $scope.favorites.push(item);
        console.log('Saved!!');
      });

    }
}]);
