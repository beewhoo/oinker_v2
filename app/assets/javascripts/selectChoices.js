
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
    evt.stopPropagation()

    if (categories.classList.contains('visible')){
      categories.classList.remove('visible');
    }
    else {
      categories.classList.add('visible');
    }}

    document.body.addEventListener('click', function(evt) {
      categories.classList.remove('visible');
    })

    var checkBox = document.querySelectorAll('.category_name')
    checkBox.forEach(function(e) {
      e.addEventListener('click', function(event) {
        event.stopPropagation();
      })
    })

    categories.addEventListener('click', function(evt) {
      evt.stopPropagation();
    })
    // checkList.onblur = function(evt) {
    //   console.log(evt)
    //   categories.classList.remove('visible');
    // }
  };



});
