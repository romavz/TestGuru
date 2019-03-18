document.addEventListener('turbolinks:load', function(){
  var test_passage = document.getElementById("test_passage")

  if (test_passage) {
    var progBar = document.getElementById("progressbar");
    var count = progBar.dataset.count - 1;
    var max = progBar.dataset.maxCount;
    progBar.style.width = (count * 100)/max + "%"
  }
})