document.addEventListener("turbolinks:load", function (params) {
  var edPasswordConfirm = document.querySelector("#user_password_confirmation");

  if (edPasswordConfirm)  {
    edPasswordConfirm.addEventListener('input', onPasswordConfirmChange);
  }
})

function onPasswordConfirmChange() {
  var edUserPassword = document.querySelector("#user_password");
  var thumbsUpIcon  = this.parentElement.querySelector(".octicon-thumbsup");
  var stopIcon      = this.parentElement.querySelector(".octicon-stop");
  passwordConfirmationValue = this.value;

  if (!passwordConfirmationValue) {
    hide(thumbsUpIcon);
    hide(stopIcon);
    return;
  }

  if (passwordConfirmationValue == edUserPassword.value) {
    show(thumbsUpIcon);
    hide(stopIcon);
  }
	else {
		show(stopIcon);
    hide(thumbsUpIcon);
	}
}

function hide(element){
  element.classList.add("hide");
}

function show(element){
  element.classList.remove("hide");
}

