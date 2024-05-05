function Validator(formSelector) {
    var _this = this;

    function getParent(element, selector) {
        while (element.parentElement) {
            if (element.parentElement.matches(selector)) {
                return element.parentElement;
            }
            element = element.parentElement;
        }
    }

    var formRules = {};
    var validatorRules = {
        required: function(value) {
            return value ? undefined : "Vui lòng nhập";
        },
        min: function(min) {
            return function(value) {
                return value.length >= min ? undefined : `Vui lòng nhập ít nhất ${min} kí tự`;
            };
        }
    };

    var formElement = document.querySelector(formSelector);

    if (formElement) {
        var inputs = formElement.querySelectorAll('[name][rules]');
        for (var input of inputs) {
            var rules = input.getAttribute("rules").split("|");
            for (var rule of rules) {
                var ruleInfo;
                var isRuleHasValue = rule.includes(':');

                if (isRuleHasValue) {
                    ruleInfo = rule.split(':');
                    rule = ruleInfo[0];
                }

                var ruleFunc = validatorRules[rule];

                if (isRuleHasValue) {
                    ruleFunc = ruleFunc(ruleInfo[1]);
                }

                if (Array.isArray(formRules[input.name])) {
                    formRules[input.name].push(ruleFunc);
                } else {
                    formRules[input.name] = [ruleFunc];
                }
            }
            input.onblur = handleValidate;
            input.oninput = handleClearError;
        }

        function handleValidate(event) {
            var rules = formRules[event.target.name];
            var errorMessage;

            for (var rule of rules) {
                errorMessage = rule(event.target.value);
                if (errorMessage) break;
            }

            if (errorMessage) {
                var formGroup = getParent(event.target, ".form-group");
                if (formGroup) {
                    formGroup.classList.add("invalid");
                    var formMessage = formGroup.querySelector(".form-message");
                    if (formMessage) {
                        formMessage.innerText = errorMessage;
                    }
                }
            }
        }

        function handleClearError(event) {
            var formGroup = getParent(event.target, ".form-group");
            if (formGroup.classList.contains("invalid")) {
                formGroup.classList.remove("invalid");

                var formMessage = formGroup.querySelector(".form-message");
                if (formMessage) {
                    formMessage.innerText = "";
                }
            }
        }
    }

    formElement.onsubmit = function(event) {
        event.preventDefault();
    
        var inputs = formElement.querySelectorAll('[name][rules]');
        var isValid = true;
    
        for (var input of inputs) {
            if (!handleValidate({ target: input })) {
                isValid = false;
            }
        }
    
        if (isValid) {
            // Lấy dữ liệu từ form
            var formData = new FormData(formElement);
            
            // Gửi request POST đến server
            fetch(formElement.action, {
                method: 'POST',
                body: formData
            })
            .then(response => {
                // Kiểm tra response từ server
                if (response.ok) {
                    // Đăng nhập thành công, chuyển hướng tới trang chính hoặc trang khác
                    window.location.href = response.url;
                } else {
                    // Đăng nhập không thành công, xử lý thông báo lỗi hoặc hiển thị lại form đăng nhập
                    console.error('Đăng nhập không thành công');
                    // Ví dụ: hiển thị thông báo lỗi
                    alert('Tên đăng nhập hoặc mật khẩu không đúng!');
                }
            })
            .catch(error => {
                console.error('Lỗi:', error);
            });
        }
    };
}

// Gọi hàm Validator sau khi DOM đã được load
document.addEventListener('DOMContentLoaded', function() {
    var form = new Validator("#sign-in-form");
});
