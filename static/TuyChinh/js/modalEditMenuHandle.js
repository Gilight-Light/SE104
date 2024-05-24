const editMenu= document.querySelector('.edit-menu-icon')
const modalEditMenu = document.querySelector('.edit-menu-modal')
const modalEditMenuContainer = document.querySelector('.edit-menu-modal-container')
const closeModalEditMenuBtn = document.querySelector('.js-modal-edit-menu-close')
const cancelEditMenuBtn = document.querySelector('.cancel-edit-menu-btn')

function OpenModel() {
	modalEditMenu.classList.add('open')
}

function HideModel() {
	modalEditMenu.classList.remove('open')
}

editMenu.addEventListener('click', OpenModel)

closeModalEditMenuBtn.addEventListener('click', HideModel)
cancelEditMenuBtn.addEventListener('click', HideModel)
modalEditMenu.addEventListener('click', HideModel)
modalEditMenuContainer.addEventListener('click', function(event) { event.stopPropagation() })