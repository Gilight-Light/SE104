let listCart = [];
function checkCart(){
        var cookieValue = document.cookie
        .split('; ')
        .find(row => row.startsWith('listCart='));
        if(cookieValue){
            listCart = JSON.parse(cookieValue.split('=')[1]);
        }
}
checkCart();

document.getElementById('saveButton').onclick = function() {
  var nameValue = document.getElementById('name').value;
  var emailValue = document.getElementById('email').value;
  var phoneValue = document.getElementById('phone').value;
  var roleValue = document.getElementById('role').value;
  
  localStorage.setItem('hoTen', nameValue);
  localStorage.setItem('email', emailValue);
  localStorage.setItem('soDienThoai', phoneValue);
  localStorage.setItem('role', roleValue);
  alert("Lưu thông tin thành công");
};

localStorage
document.getElementById('name').value = localStorage.getItem('hoTen');
document.getElementById('name2').value = localStorage.getItem('hoTen');
document.getElementById('email').value = localStorage.getItem('email');
document.getElementById('phone').value = localStorage.getItem('soDienThoai');
document.getElementById('role').value = localStorage.getItem('role');


document.getElementById("appointment-time").value = localStorage.getItem('appointmentTime');
document.getElementById("confirmButton").onclick = function() {
      var appointmentTime = document.getElementById('appointment-time').value;
      localStorage.setItem('appointmentTime', appointmentTime);
      alert("Đăng ký thành công");
    };


let today = new Date();
let formattedDate = today.toISOString().substring(0, 16);
document.getElementById('payment-time').value = formattedDate;



function createCheckoutForm() {
    let checkoutForm = document.getElementById('checkoutForm');
  
    if (listCart && listCart.length > 0) {
  
      let validProducts = listCart.filter(product => product !== null);
  
      if (validProducts.length > 0) {
        let total = 0; 
        let types = ['Sảnh cưới', 'Thực đơn đã chọn', 'Dịch vụ đã chọn'];
  
        types.forEach((type) => {
          let typeTitleDiv = document.createElement('div');
          typeTitleDiv.innerHTML = `<h2>${type}</h2>`;
          
          let typeProducts = listCart.filter((product) => (
            product && product.type && product.type.toLowerCase().replaceAll(' ', '') === type.toLowerCase().replaceAll(' ', '')
          ));
          
          typeProducts.forEach((product) => {
            total = total + (product.price * product.quantity);
            let productDiv = document.createElement('div');
            productDiv.classList.add('item');
            productDiv.innerHTML = 
            `<img src="${product.image}">
             <div class="info">
                <div class="name">${product.name}</div>
                ${product.type === 'Sảnh cưới' ? `<div class="quantity">SL bàn: ${product.quantity}</div>` : ''}
            </div>
            <div class="returnPrice">$${product.price * product.quantity}</div>
            ${product.type === 'Sảnh cưới' ? `<div class="address">${product.address}</div>` : ''}`;

            typeTitleDiv.appendChild(productDiv);
          });
  
          checkoutForm.appendChild(typeTitleDiv);
        });

        let totalDiv = document.createElement('div');
        totalDiv.innerHTML = `<div class="total-price">Tổng thanh toán: $${total}</div>`;
        checkoutForm.appendChild(totalDiv);

      } else {
        let noProductDiv = document.createElement('div');
        noProductDiv.innerHTML = `<p>Chưa có dịch vụ nào được đăng ký</p>`;
        checkoutForm.appendChild(noProductDiv);
      }
    }
  }
  
  createCheckoutForm();