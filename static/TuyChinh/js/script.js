var item = document.querySelectorAll(".navbar-item")
var heading = document.querySelector(".heading")
var contentPage = Array.from(document.querySelectorAll(".content-page"))

var arrayItem = Array.from(item)
arrayItem[0].onclick = function(e) {
    heading.innerHTML = arrayItem[0].textContent
    var selfInfo = contentPage.find(function(Page) {return Page.classList.contains("self-info")})
    if (selfInfo.classList.contains("hidden")) {
        contentPage.forEach(function(Page) {
            Page.classList.add("hidden")
        })
        selfInfo.classList.remove("hidden")
    }
}

arrayItem[1].onclick = function(e) {
    heading.innerHTML = arrayItem[1].textContent
    var guest = contentPage.find(function(Page) {return Page.classList.contains("guest")})
    if (guest.classList.contains("hidden")) {
        contentPage.forEach(function(Page) {
            Page.classList.add("hidden")
        })
        guest.classList.remove("hidden")
    }
}

arrayItem[2].onclick = function(e) {
    heading.innerHTML = "Báo cáo doanh thu"
    var statistical = contentPage.find(function(Page) {return Page.classList.contains("statistical")})
    if (statistical.classList.contains("hidden")) {
        contentPage.forEach(function(Page) {
            Page.classList.add("hidden")
        })
        statistical.classList.remove("hidden") 
    }
}

arrayItem[3].onclick = function(e) {
    heading.innerHTML = arrayItem[3].textContent
    var lobby = contentPage.find(function(Page) {return Page.classList.contains("lobby-management")})
    if (lobby.classList.contains("hidden")) {
        contentPage.forEach(function(Page) {
            Page.classList.add("hidden")
        })
        lobby.classList.remove("hidden")  
    }
}

arrayItem[4].onclick = function(e) {
    heading.innerHTML = arrayItem[4].textContent
    var service = contentPage.find(function(Page) {return Page.classList.contains("service-management")})
    if (service.classList.contains("hidden")) {
        contentPage.forEach(function(Page) {
            Page.classList.add("hidden")
        })
        service.classList.remove("hidden")
    }
}

arrayItem[5].onclick = function(e) {
    heading.innerHTML = arrayItem[5].textContent
    var menu = contentPage.find(function(Page) {return Page.classList.contains("menu-management")})
    if (menu.classList.contains("hidden")) {
        contentPage.forEach(function(Page) {
            Page.classList.add("hidden")
        })
        menu.classList.remove("hidden")  
    }
}
arrayItem[6].onclick = function(e) {
    heading.innerHTML = arrayItem[6].textContent
    var shift = contentPage.find(function(Page) {return Page.classList.contains("shift-management")})
    if (shift.classList.contains("hidden")) {
        contentPage.forEach(function(Page) {
            Page.classList.add("hidden")
        })
        shift.classList.remove("hidden")  
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

document.getElementById('form-select-ca').addEventListener('change', function() {
    var selectedForm = this.value;
    var forms = document.querySelectorAll('.form-row');
    var formca = document.querySelector('.form-ca')
    
    forms.forEach(function(form) {
        if (form.id === selectedForm) {
            formca.classList.remove("hidden")
            form.style.display = 'flex';
        } else {
            form.style.display = 'none';
        }
    });
});
