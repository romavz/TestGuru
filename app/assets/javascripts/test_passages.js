document.addEventListener('turbolinks:load', function(){
  var test_passage = document.getElementById("test_passage");

  if (test_passage) {
    var progBar = document.getElementById("progressbar");
    var count = progBar.dataset.count - 1;
    var max = progBar.dataset.maxCount;
    progBar.style.width = (count * 100)/max + "%"
  }

  var timer = document.getElementById("timer");
  if (!timer) { return; }

  var availableTimeInSeconds = parseInt(timer.dataset.availableTimeInSeconds, 10);
  var updateTimerShedullerID = null;

  showTimer();

  if (availableTimeInSeconds > 0) {
    setTimeout(submitForm, availableTimeInSeconds * 1000);
    updateTimerShedullerID  = setInterval(updateTimer, 1000);
  }

  function submitForm() {
    clearInterval(updateTimerShedullerID);
    document.forms["answers_form"].submit();
  }

  function updateTimer() {
    if (availableTimeInSeconds <= 0) { return; }
    availableTimeInSeconds -= 1;

    showTimer();
  }

  function showTimer() {
    var second = 1;
    var minute = (second * 60);
    var hour = (minute * 60);
    var minutes = Math.floor((availableTimeInSeconds % hour) / minute);
    var seconds = Math.floor((availableTimeInSeconds % minute) / second);

    timer.innerText = minutes + " : " + seconds;
  }
});