const nav = document.querySelector('nav');
        const toggle_menu = document.querySelector('.toggle_menu');
        const content = document.querySelector('.content');

        toggle_menu.onclick = function () {
        nav.classList.toggle('hide');
        content.classList.toggle('expand'); 
}