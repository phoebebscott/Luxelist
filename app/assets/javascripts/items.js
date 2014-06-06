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
  return $http({method: 'GET', url: 'http://search.3taps.com/?auth_token=a3d09bcb83580db63e9fd0cac1af5cac&rpp=100&retvals=external_id,category,heading,body,images,price,location,external_url&category=SFUR&radius=15mi&lat=34.05256&long=-118.44193&price=1000..&heading=("sofa")'});
  console.log("after returning resource");
}]);

// <<<<<<< HEAD ----Need to resolve this conflict with Will
itemApp.controller('ItemCtrl', ['$scope', 'Item', 'Location', function($scope, Item, Location) {
// =======
// wrapper around call to $resource, which calls the API
itemApp.factory('Favorite', ['$resource', function($resource) {
  return $resource('/favorites/:id',
     {id: '@id'},
     {update: { method: 'PATCH'}});
}]);


itemApp.controller('ItemCtrl', ['$scope', 'Item', 'Favorite', function($scope, Item, Favorite) {
// >>>>>>> marysbranch --Need to resolve this conflict with Will
    $scope.items= [];
    $scope.favorites = [];

    Item.success(function(data, status, headers, config) {
      $scope.items = data.postings;
    });

    

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
        
        console.log("here are the items");
        console.log($scope.items);
      });
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

// locationApp.controller('LocationCtrl', ['$scope', 'Location', function($scope, Location) {
//     $scope.items= [];
//     console.log("in the controller");

//      Item.success(function(data, status, headers, config) {
//         $scope.items = data.postings;
//         console.log("here are the items");
//         console.log($scope.items);
//       });
// }]);



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
