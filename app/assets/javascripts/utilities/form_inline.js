document.addEventListener('turbolinks:load', function () {
  $formInlineLink = $(".form-inline-link");

  if ($formInlineLink.length == 0) {
    return;
  }

  $formInlineLink.on("click", formInlineLinkHandler);

  var errors = document.querySelector(".resource-errors");
  if (errors){
    var resourceId = errors.dataset.resourceId;
    formInlineHandler(resourceId);
  }
})

function formInlineLinkHandler(event) {
  event.preventDefault();
  var testId = this.dataset.testId;
  formInlineHandler(testId);
}

function formInlineHandler(testId){
  var link = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]')
  var $testTitle = $('.test-title[data-test-id="' + testId + '"]')
  var $formInline = $('.form-inline[data-test-id="' + testId + '"]')

  $testTitle.toggleClass('hide');
  $formInline.toggleClass('hide');
  togleLinkText(link);
}

function togleLinkText(link){
  var title1 = link.dataset.title1;
  var title2 = link.dataset.title2;

  if (link.textContent == title1) {
    link.textContent = title2
  } else {
    link.textContent = title1
  }
}