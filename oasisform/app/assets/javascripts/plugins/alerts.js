document.addEventListener('click', function (event) {
  if (event.target.parentNode.matches('.exit-alert')) {
    event.target.parentNode.parentNode.remove()
  }
});