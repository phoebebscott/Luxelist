var itemApp = angular.module('items_app', ['ngResource']).config(

// this is the function that makes an http request
  ['$httpProvider', function($httpProvider) {
  var defaults = $httpProvider.defaults.headers;

  defaults.patch = defaults.patch || {};
  defaults.patch['Content-Type'] = 'application/json';
  defaults.common['Accept'] = 'application/json';

}]);

// creates 'promise' to GET API search data
  itemApp.factory('Item', ['$http', function($http) {
    return $http({method: 'GET', url: 'http://search.3taps.com/?auth_token=a3d09bcb83580db63e9fd0cac1af5cac&rpp=100&retvals=external_id,category,heading,body,images,price,location,external_url&category=SFUR&radius=15mi&lat=34.05256&long=-118.44193&price=1000..&heading=("sofa")'});
  }]);



// added Favorites detail to item controller per Jonny
  itemApp.controller('ItemCtrl', ['$scope', 'Item', 'Favorite', 'Location', function($scope, Item, Favorite, Location) {

      $scope.items= [];
        Item.success(function(data, status, headers, config) {
          $scope.items = data.postings;


          locations = {}
          for (i=0; i<data.postings.length; i++) {
            locations[$scope.items[i].location.city] = locations[$scope.items[i].location.city] || []
            locations[$scope.items[i].location.city].push($scope.items[i]);
          }

          for (city in locations) {
            Location.forCity(city).success(function(data, status, headers, config) {
              locations[data.location.code].forEach(function(posting) {
                posting.cityName = data.location.short_name;
              });
            });
          };
        });

      $scope.favorites = [];

      $scope.favoritesAll = [];

      Favorite.query(function(dbFavorites){
        $scope.favoritesAll = dbFavorites;
      });

      $scope.addFavorite = function(item) {
        console.log(item);
        $scope.newFavorite = new Favorite(
          {
            item: {
              // external_id: item.external_id,
              external_url: item.external_url,
              image_url: item.images[0].full,
              title: item.heading,
              price: item.price,
              location: item.cityName
            }
          });

        console.log($scope.newFavorite);

        $scope.newFavorite.$save(function(item) {
          $scope.favorites.push(item);
          console.log('Saved!!');
        });
      };
  }]);

  itemApp.factory('Location', ['$http', function($http) {
    console.log("before returning location");
    var Location = {
      forCity: function(cityCode) {
        return $http({method: 'GET', url: 'http://reference.3taps.com/locations/lookup/?auth_token=a3d09bcb83580db63e9fd0cac1af5cac&code='+cityCode});
      }
    };
    return Location;

    console.log("after returning location");
  }]);

  // wrapper around call to $resource, which calls the API. Jonny's suggestion...is this correct to add for favorites??
  itemApp.factory('Favorite', ['$resource', function($resource) {
    var authToken = angular.element("meta[name=\"csrf-token\"]").attr("content");

    return $resource('/favorites/:id',
       {id: '@id'},
       {update: { method: 'PATCH', headers: { "X-CSRF-TOKEN" : authToken }},
        save: { method: 'POST', headers: { "X-CSRF-TOKEN" : authToken }}});
  }]);





