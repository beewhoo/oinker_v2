document.addEventListener("DOMContentLoaded", function(event) {
    console.log("DOM fully loaded and parsed");


    // quantity of seats and participants

    var plus = document.querySelector('.qtyplus');
    var minus = document.querySelector('.qtyminus');
    var quantity = document.querySelector('.qty');

    var value = 1

    plus.addEventListener('click',function(){
      quantity.value = value;
      var newValue = value++;

    minus.addEventListener('click',function(){
        quantity.value = newValue;
        if (newValue > 0)
        newValue--;
        if (newValue === 0)
        value = 1;
      })

    })

    // postalcode capture and validation

    var postalTest = RegExp(/^\s*[a-ceghj-npr-tvxy]\d[a-ceghj-npr-tv-z](\s)?\d[a-ceghj-npr-tv-z]\d\s*$/i);
    var postalCode = document.querySelector('.pstbox');


    postalCode.addEventListener('keyup', function(event){

      if (postalTest.test(postalCode.value)=== true){
        postalCode.style.border = '2px solid #98fb98'
      } else {
        postalCode.style.border = '2px solid red'
      }

    })





  });
