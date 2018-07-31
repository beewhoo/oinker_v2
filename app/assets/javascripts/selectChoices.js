
document.addEventListener('DOMContentLoaded', function(){

// DATE CHOICE
$( function() {
  $( "#datepicker" ).datepicker();
} );

// BUDGET CHOICE
$( function() {
   $( "#slider-range-max" ).slider({
     range: "max",
     min: 10,
     max: 100,
     value: 2,
     slide: function( event, ui ) {
       $( "#amount" ).val( ui.value );
     }
   });
   $( "#amount" ).val( $( "#slider-range-max" ).slider( "value" ) );
 } );

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
