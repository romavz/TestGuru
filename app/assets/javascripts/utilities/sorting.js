document.addEventListener("turbolinks:load", function (params) {
  var titleControl = document.querySelector(".sort-by-title")

  if (titleControl) { titleControl.addEventListener('click', sortRowsByTitle) }
})

function sortRowsByTitle() {
  var unSortedtable = document.querySelector(".table")

  var rowsNodeList = unSortedtable.querySelectorAll("tr")
  var sortedRows = [].slice.call(rowsNodeList, 1)

  var arrow_up = this.querySelector(".octicon-triangle-up")
  var arrow_down = this.querySelector(".octicon-triangle-down")

  if (arrow_up.classList.contains("hide")) {
    sortedRows.sort(compareRowsAsc)
    arrow_up.classList.remove("hide")
    arrow_down.classList.add("hide")
  }
  else {
    sortedRows.sort(compareRowsDesc)
    arrow_up.classList.add("hide")
    arrow_down.classList.remove("hide")
  }

  var sortedTable = document.createElement("table")

  sortedTable.className = unSortedtable.className
  sortedTable.appendChild(rowsNodeList[0])

  for (var i = 0; i < sortedRows.length; i++){
    sortedTable.appendChild(sortedRows[i])
  }

  unSortedtable.parentElement.replaceChild(sortedTable, unSortedtable)
}

function getTestTitle(row){
  return row.querySelector(".title").textContent
}

function compareRowsAsc(row1, row2){
  return compareRows(row1, row2, 1)
}

function compareRowsDesc(row1, row2){
  return compareRows(row1, row2, -1)
}

function compareRows(row1, row2, direction) {
  debugger
  var testTitle1 = getTestTitle(row1)
  var testTitle2 = getTestTitle(row2)

  if (testTitle1 < testTitle2) { return -1 * direction }
  if (testTitle2 < testTitle1) { return 1 * direction }
  return 0
}