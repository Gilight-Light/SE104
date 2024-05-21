var item = document.querySelectorAll(".navbar-item")
var heading = document.querySelector(".heading")
var selfInfo = document.querySelector(".self-info")
var guest = document.querySelector(".guest")
var statistical = document.querySelector(".statistical")
var lobby = document.querySelector(".lobby-management")
var service = document.querySelector(".service-management")
var menu = document.querySelector(".menu-management")

var arrayItem = Array.from(item)
arrayItem[0].onclick = function(e) {
    heading.innerHTML = arrayItem[0].textContent
    console.log(selfInfo)
    if (selfInfo.classList.contains("hidden")) {
        selfInfo.classList.remove("hidden")
        guest.classList.add("hidden")
        statistical.classList.add("hidden")
        lobby.classList.add("hidden")
        service.classList.add("hidden")
        menu.classList.add("hidden")
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
        lobby.classList.add("hidden")
        service.classList.add("hidden")
        menu.classList.add("hidden")
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
        lobby.classList.add("hidden")
        service.classList.add("hidden")
        menu.classList.add("hidden")
    } else {
        statistical.classList.add("hidden")
    }
    
    // Loại bỏ lớp CSS .hidden khỏi phần chứa biểu đồ
    var chartWrapper = document.querySelector('.chart-wrapper');
    if (chartWrapper) {
        chartWrapper.classList.remove('hidden');
    }
}

arrayItem[3].onclick = function(e) {
    heading.innerHTML = arrayItem[3].textContent
    if (lobby.classList.contains("hidden")) {
        lobby.classList.remove("hidden")
        selfInfo.classList.add("hidden")
        guest.classList.add("hidden")
        statistical.classList.add("hidden")
        service.classList.add("hidden")
        menu.classList.add("hidden")
    } else {
        lobby.classList.add("hidden")
        
    }
}

arrayItem[4].onclick = function(e) {
    heading.innerHTML = arrayItem[4].textContent
    if (service.classList.contains("hidden")) {
        service.classList.remove("hidden")
        selfInfo.classList.add("hidden")
        guest.classList.add("hidden")
        lobby.classList.add("hidden")
        statistical.classList.add("hidden")
        menu.classList.add("hidden")

    } else {
        service.classList.add("hidden")
        
    }
}

arrayItem[5].onclick = function(e) {
    heading.innerHTML = arrayItem[5].textContent
    if (menu.classList.contains("hidden")) {
        menu.classList.remove("hidden")
        selfInfo.classList.add("hidden")
        guest.classList.add("hidden")
        lobby.classList.add("hidden")
        statistical.classList.add("hidden")
        service.classList.add("hidden")
    } else {
        menu.classList.add("hidden")
    }
}

document.getElementById('form-select-lobby').addEventListener('change', function() {
    var selectedForm = this.value;
    var forms = document.querySelectorAll('.form-row');
    var formLobby = document.querySelector('.form-lobby')
    
    forms.forEach(function(form) {
        if (form.id === selectedForm) {
            formLobby.classList.remove("hidden")
            form.style.display = 'flex';
        } else {
            form.style.display = 'none';
        }
    });
});

document.getElementById('form-select-service').addEventListener('change', function() {
    var selectedForm = this.value;
    var forms = document.querySelectorAll('.form-row');
    var formService = document.querySelector('.form-service')
    
    forms.forEach(function(form) {
        if (form.id === selectedForm) {
            formService.classList.remove("hidden")
            form.style.display = 'flex';
        } else {
            form.style.display = 'none';
        }
    });
});

document.getElementById('form-select-menu').addEventListener('change', function() {
    var selectedForm = this.value;
    var forms = document.querySelectorAll('.form-row');
    var formMenu = document.querySelector('.form-menu')
    
    forms.forEach(function(form) {
        if (form.id === selectedForm) {
            formMenu.classList.remove("hidden")
            form.style.display = 'flex';
        } else {
            form.style.display = 'none';
        }
    });
});