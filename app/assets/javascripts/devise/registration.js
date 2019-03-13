document.addEventListener("turbolinks:load", function (params) {
  edPasswordConfirm = document.querySelector("#user_password_confirmation")
  edUserPassword = document.querySelector("#user_password")
  thumbsUpIcon = edPasswordConfirm.parentElement.querySelector(".octicon-thumbsup")
  stopIcon = edPasswordConfirm.parentElement.querySelector(".octicon-stop")

  if (edPasswordConfirm)  { edPasswordConfirm.addEventListener('input', checkPasswordsEquals) }
})

var edUserPassword, edPasswordConfirm;
var thumbsUpIcon, stopIcon;

function checkPasswordsEquals() {
  if (!this.value) {
    hide(thumbsUpIcon)
    hide(stopIcon)
    return
  }

  if (this.value == edUserPassword.value) {
    show(thumbsUpIcon)
    hide(stopIcon)
  }
	else {
		show(stopIcon)
    hide(thumbsUpIcon)
	}
}

function hide(element){
  element.classList.add("hide")
}

function show(element){
  element.classList.remove("hide")
}

