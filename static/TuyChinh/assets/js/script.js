var item = document.querySelectorAll(".navbar-item")
var heading = document.querySelector(".heading")
var selfInfo = document.querySelector(".self-info")
var guest = document.querySelector(".guest")
var statistical = document.querySelector(".statistical")

var arrayItem = Array.from(item)
arrayItem[0].onclick = function(e) {
    heading.innerHTML = arrayItem[0].textContent
    console.log(selfInfo)
    if (selfInfo.classList.contains("hidden")) {
        selfInfo.classList.remove("hidden")
        guest.classList.add("hidden")
        statistical.classList.add("hidden")
    } else {
        selfInfo.classList.add("hidden")
    }
}

arrayItem[1].onclick = function(e) {
    heading.innerHTML = arrayItem[1].textContent
    if (guest.classList.contains("hidden")) {
        guest.classList.remove("hidden")
        selfInfo.classList.add("hidden")
        statistical.classList.add("hidden")
    } else {
        guest.classList.add("hidden")
        
    }
}

arrayItem[2].onclick = function(e) {
    heading.innerHTML = "Báo cáo doanh thu"
    if (statistical.classList.contains("hidden")) {
        statistical.classList.remove("hidden")
        selfInfo.classList.add("hidden")
        guest.classList.add("hidden")
    } else {
        statistical.classList.add("hidden")
        
    }
}