
document.addEventListener('DOMContentLoaded', function(){

// DATE CHOICE
$( function() {
  $( "#datepicker" ).datepicker();
} );

// BUDGET CHOICE
$( function() {
   $( "#slider-range-max" ).slider({
     range: "max",
     min: 15,
     max: 80,
     value: 2,
     slide: function( event, ui ) {
       $( "#amount" ).val( ui.value );
     }
   });
   $( "#amount" ).val( $( "#slider-range-max" ).slider( "value" ) );
 } );

// CATEGORY CHOICE

var checkList = document.querySelectorAll('.dropdown-check-list')

checkList.forEach(function(e) {
  checkListDrop(e);
});

function checkListDrop(checkList) {
  if (checkList === null) {
    return
  }
  var categories = checkList.querySelector('.categories')

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
  };



});
