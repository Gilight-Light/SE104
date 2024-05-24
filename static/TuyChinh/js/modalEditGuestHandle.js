
	const editGuest= document.querySelector('.edit-guest-icon')
	const modalEditGuest = document.querySelector('.edit-guest-modal')
	const modalEditGuestContainer = document.querySelector('.edit-guest-modal-container')
	const closeModalEditGuestBtn = document.querySelector('.js-modal-edit-guest-close')
	const cancelEditGuestBtn = document.querySelector('.cancel-edit-guest-btn')
	function Open() {
		modalEditGuest.classList.add('open')
	}

	function Hide() {
		modalEditGuest.classList.remove('open') 
	}

	editGuest.addEventListener('click', function(){
		var row = $(this).closest('tr');
		var hoTen = row.find('td:nth-child(1)').text();
		var NgayToChuc = row.find('td:nth-child(7)').text();
        var MaSanh = row.find('td:nth-child(13)').text();
        var MaThucDon = row.find('td:nth-child(15)').text();
        var MaDichVu = row.find('td:nth-child(14)').text();
        var TienCoc = row.find('td:nth-child(16)').text();
        var tongTienThanhToan = row.find('td:nth-child(6)').text().replace('$', '');
       

		$('#user-name').val(hoTen);
		$('#lobby-date').val(NgayToChuc);
		$('#lobby-name').val(MaSanh);
		$('#lobby-menu').val(MaThucDon);
		$('#lobby-service').val(MaDichVu);
		$('#lobby-SumMoney').val(tongTienThanhToan);
		$('#lobby-money').val(TienCoc);
		modalEditGuest.classList.add('open')
	})

	closeModalEditGuestBtn.addEventListener('click', Hide)
	cancelEditGuestBtn.addEventListener('click', Hide)
	modalEditGuest.addEventListener('click', Hide)
	modalEditGuestContainer.addEventListener('click', function(event) { event.stopPropagation() })
