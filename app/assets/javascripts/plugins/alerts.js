// Jquery Version Sort of works removes alert on any click
// $(document).on('click', '.exit-alert', function () {
//   $(this).parent().hide();
// }); 

// Javascript version using EventListener
document.addEventListener('click', function (event) {
  // if we have the correct click event proceed
  if (event.target.parentNode.matches('.exit-alert')) {
    // set the correct div we need to remove
    element = event.target.parentNode.parentNode;
    // remove div
    element.parentNode.removeChild(element);
  }
}, false);

