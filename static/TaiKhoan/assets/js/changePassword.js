const changePassword = document.querySelector('.change-password')
const modal = document.querySelector('.js-modal')
const modalContainer = document.querySelector('.js-modal-container')
const modalClose = document.querySelector('.js-modal-close')

console.log(changePassword)
function Open() {
    modal.classList.add('open')
}

function Hide() {
    modal.classList.remove('open')
}

changePassword.addEventListener('click', Open)

modalClose.addEventListener('click', Hide)
modal.addEventListener('click', Hide)
modalContainer.addEventListener('click', function (event) { event.stopPropagation() })

var header = document.getElementById('header');
var mobileMenu = document.getElementById('mobile-menu');
var headerHeight = header.clientHeight;

mobileMenu.onclick = function () {
    var isClose = header.clientHeight === headerHeight;
    if (isClose) {
        header.style.height = 'auto';
    } else {
        header.style.height = null;
    }
}

var menuItems = document.querySelectorAll('#nav > li a[href*="#"]')
for (var i = 0; i < menuItems.length; i++) {
    var menuItem = menuItems[i];

    menuItem.onclick = function (event) {
        var isParentMenu = this.nextElementSibling && this.nextElementSibling.classList.contains('subnav');
        if (isParentMenu) {
            event.preventDefault();
        } else {
            header.style.height = null;
        }
    }
}