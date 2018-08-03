
document.addEventListener("DOMContentLoaded", function(event) {
    console.log("DOM fully loaded and parsed");

    // quantity of seats and participants

    var plus = document.querySelector('.qtyplus');
    var minus = document.querySelector('.qtyminus');
    var quantity = document.querySelector('.qty');

    if (plus && minus && quantity) {
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
    }



    // postalcode capture and validation

    var postalTest = RegExp(/^\s*[a-ceghj-npr-tvxy]\d[a-ceghj-npr-tv-z](\s)?\d[a-ceghj-npr-tv-z]\d\s*$/i);
    var postalCode = document.querySelector('.pstbox');

      if (postalCode) {
      postalCode.addEventListener('keyup', function(event){

          if (postalTest.test(postalCode.value)=== true){
            postalCode.style.border = '2px solid #98fb98'
          } else {
            postalCode.style.border = '2px solid red'
          }

        })
      }

//preload ajax



var container = document.querySelector('.gallery');


if  (container) {
//event
$.ajax({
  url:'/events',
  method:'GET',
  dataType: 'json'
}).done(function(responseData){
  console.log(responseData);

  responseData.forEach(function(e){
    var div = document.createElement('div')
    var image = document.createElement('img')
    var p = document.createElement('p')

    image.src = e.image_url
    image.classList='gallery-image'
    div.append(image)
    div.classList ='gallery-item'
    // p.innerText = e.name
    // p.style.color = 'blue'
    // div.append(p)
    container.append(div)


  });

});

//res

$.ajax({
url:'/restaurants',
method:'GET',
dataType: 'json'
}).done(function(responseRest){
console.log(responseRest);
responseRest.forEach(function(e){
var div2 = document.createElement('div')
var image = document.createElement('img')
var p = document.createElement('p')

image.src = e.image_url
image.style.height = '200px'
image.classList='galler-image'
div2.append(image)
div2.classList ='gallery-item'
// p.innerText = e.name
// p.style.color = 'blue'
// div2.append(p)
container.append(div2)


});

});


}







///jquery load more clik ajax call and scroll


jqueryCheck(function($) {
  // jQuery exists, and we can use local scope $ object

  var seeMoreButtonNode = document.getElementById('seeMoreButton');
  seeMoreButton(seeMoreButtonNode);

  var backToTopButtonNode = document.getElementById('backToTopButton');
  backToTopButton(backToTopButtonNode);
});

// "See More" button functionality
function seeMoreButton(button) {
  if (!button) return; // Button doesn't exist, return to prevent errors.

  $(button).parent()
     .animate({ bottom: 1 })
     .animate({ bottom: 0 });

  // Event listener for click on "See More" button
  button.addEventListener('click', function() {
    var container = document.querySelector('.gallery');

      $.ajax({
        url:'/events',
        method:'GET',
        dataType: 'json'
      }).done(function(responseData){
        console.log(responseData);

        responseData.forEach(function(e){
          var div = document.createElement('div')
          var image = document.createElement('img')
          var p = document.createElement('p')

          image.src = e.image_url
          image.classList='gallery-image'
          div.append(image)
          div.classList ='gallery-item'
          // p.innerText = e.name
          // p.style.color = 'blue'
          // div.append(p)
          container.append(div)


        });

      });

          //res

          $.ajax({
            url:'/restaurants',
            method:'GET',
            dataType: 'json'
          }).done(function(responseRest){
          console.log(responseRest);
            responseRest.forEach(function(e){
              var div2 = document.createElement('div')
              var image = document.createElement('img')
              var p = document.createElement('p')

              image.src = e.image_url
              image.style.height = '200px'
              image.classList='galler-image'
              div2.append(image)
              div2.classList ='gallery-item'
              // p.innerText = e.name
              // p.style.color = 'blue'
              // div2.append(p)
              container.append(div2)


            });

          });

          ////load up


            var newPosition = $(window).scrollTop() + 200;
            scrollPage(newPosition);
          }, false);
        }

        // Back to top button functionality
        function backToTopButton(button) {
          if (!button) return; // Button doesn't exist, return to prevent errors.

          // Event listener for click on "See More" button
          button.addEventListener('click', function() {
            scrollPage(0);
          }, false);

          // Implement throttle on window scroll
          window.onscroll = throttle(function() {
            if (window.scrollY > 1000) {
              button.parentNode.setAttribute('data-active', true);
            } else {
              button.parentNode.setAttribute('data-active', false);
            }
          });
        }

        // Scroll a page
        function scrollPage(yPos) {
          $('html, body').stop().animate({ scrollTop: yPos }, "easein");
        }


        function throttle(callback) {
          // Get current timestamp
        	var time = Date.now();
        	return function() {
            // Check if timestamp is 100ms later
        		if ((time + 100 - Date.now()) < 0) {
              // Fire callback
        			callback();
              // Update for next time
              time = Date.now();
        		}
        	}
        }


      //need to know whats happening here

      function jqueryCheck(callback, count) {
        // If count isn't defined, set it to 1
        count = (typeof count !== 'undefined') ?  count : 1;

        // Check for jQuery object, and isReady boolean property
      	if (window.jQuery !== undefined && window.jQuery.isReady) {
          // Return the callback function, with the found jQuery object
      		return callback(window.jQuery);
        // jQuery wasn't found
        // If the count is below 30, run again after 100ms
      	} else if (count < 30) {
      		setTimeout(function() {
            // Run the same function
            // Pass the callback function, and an incremented count.
      			jqueryCheck(callback, count + 1);
      		}, 100);
      	} else {
          // No jQuery found
        }
      }


      //collapsible about us page
      var coll = document.getElementsByClassName("collapsible");
      var i;

      for (i = 0; i < coll.length; i++) {
        coll[i].addEventListener("click", function() {
          this.classList.toggle("active");
          var content = this.nextElementSibling;
          if (content.style.maxHeight){
            content.style.maxHeight = null;
          } else {
            content.style.maxHeight = content.scrollHeight + "px";
          }
        });
      }


//dom loaded
});
