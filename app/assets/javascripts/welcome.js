//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

document.addEventListener("DOMContentLoaded", function(event) {
    console.log("DOM fully loaded and parsed");

    var title = document.querySelector(".welcomeOinklet");

    title.addEventListener("click", function() {
      title.style.color = "red";
    });

  });
