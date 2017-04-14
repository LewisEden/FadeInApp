$(document).on('turbolinks:load', function() {
  function myFunction() {
    var x = document.getElementById("dropdown");
    if (x.className.indexOf("w3-show") == -1) 
        x.className += " w3-show";
    else 
        x.className = x.className.replace(" w3-show", "");
    }
}