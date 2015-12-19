app.filter('roundFloat',function() {
  return function(input) {
    var numPlaces = 4; 
    return Math.round(input * Math.pow(10,numPlaces)) / Math.pow(10,numPlaces);
  };
});