
document.addEventListener('DOMContentLoaded', function(){

// DATE CHOICE
$( function() {
  $( "#datepicker" ).datepicker();
} );

// BUDGET CHOICE
$( function() {
  $( "#slider-range" ).slider({
    range: true,
    min: 0,
    max: 100,
    values: [ 25, 75 ],
    slide: function( event, ui ) {
      $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
    }
  });
  $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
    " - $" + $( "#slider-range" ).slider( "values", 1 ) );
  });

// CATEGORY CHOICE

var checkList = document.getElementById('catlist')

if (checkList !== null) {
  var categories = document.querySelector('.categories')
  checkList.getElementsByClassName('anchor')[0].onclick = function (evt) {
    if (categories.classList.contains('visible')){
      categories.classList.remove('visible');
    }
    else {
      categories.classList.add('visible');
    }}
    checkList.onblur = function(evt) {
      categories.classList.remove('visible');
    }
  };



});
