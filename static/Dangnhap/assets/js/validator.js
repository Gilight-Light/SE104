function Validator(formSelector) {
    var _this = this

    function getParent(element, selector) {
        while (element.parentElement) {
            if (element.parentElement.matches(selector)) {
                return element.parentElement
            }
            element = element.parentElement
        }
    }

    var formRules = {}
    var validatorRules = {
        required: function (value) {
            return value ? undefined : "Vui lòng nhập"
        },
        email: function (value) {
            var emailRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
            var regexInstance = new RegExp(emailRegex);
            return regexInstance.test(value) ? undefined : "Vui lòng nhập email"
        },
        min: function (min) {
            return function (value) {
                return value.length >= min ? undefined : `Vui lòng nhập ít nhất ${min} kí tự`
            }
        }
    }
    // Lấy ra form element trong DOM theo `formSelector`
    var formElement = document.querySelector(formSelector)

    // Chỉ xử lý khi có element trong DOM
    if (formElement) {
        var inputs = formElement.querySelectorAll('[name][rules]')
        for (var input of inputs) {
            var rules = input.getAttribute("rules").split("|")
            for (var rule of rules) {
                var ruleInfo
                var isRuleHasValue = rule.includes(':')

                if (isRuleHasValue) {
                    ruleInfo = rule.split(':')
                    rule = ruleInfo[0]
                }

                var ruleFunc = validatorRules[rule]

                if (isRuleHasValue) {
                    ruleFunc = ruleFunc(ruleInfo[1])
                }

                if (Array.isArray(formRules[input.name])) {
                    formRules[input.name].push(ruleFunc)
                } else {
                    formRules[input.name] = [ruleFunc]
                }
            }
            // Lắng nghe sự kiện để validate
            input.onblur = handleValidate
            input.oninput = handleClearError
        }

        // hàm thực hiện sự hiện
        function handleValidate(event) { 
            var rules = formRules[event.target.name]
            var errorMessage

            for (var rule of rules) {
                errorMessage = rule(event.target.value)
                if(errorMessage) break 
            }

            // Nếu có lỗi hiển thị ra UI
            if (errorMessage) {
                var formGroup = getParent(event.target, ".form-group")
                if (formGroup) {
                    formGroup.classList.add("invalid")
                    var formMessage = formGroup.querySelector(".form-message")
                    if (formMessage) {
                        formMessage.innerText = errorMessage
                    }
                }
            }
        }

        function handleClearError(event) {
            var formGroup = getParent(event.target, ".form-group")
            if (formGroup.classList.contains("invalid")) {
                formGroup.classList.remove("invalid")

                var formMessage = formGroup.querySelector(".form-message")
                    if (formMessage) {
                        formMessage.innerText = ""
                    }
            }
        }
    }

    formElement.onsubmit = function(event) {
        event.preventDefault()

        var inputs = formElement.querySelectorAll('[name][rules]')
        var isValid = true

        for (var input of inputs) {
            if (!handleValidate({ target: input})) {
                isValid = false
            }
        }

        // khi không có lỗi thì submit form
        if(isValid) {
            if (typeof _this.onsubmit === "function") {
                var enableInputs = formElement.querySelectorAll("[name]")
                var formValue = Array.from(enableInputs).reduce(function (values,input) {

                    switch(input.type) {
                        case 'radio':
                            values[input.name] = formElement.querySelector('input[name="' + input.name + '"]:checked').value
                            break
                        case 'checkbox':
                            if (!input.matches('checked')) return values
                            if(!Array.isArray(values[input.name])) {
                                values[input.name] = []
                            } 
                            values[input.name].push(input.value)
                            break
                        default:
                            values[input.name] = input.value
                    }

                    return values
                })
            } else {
                formElement.submit()
            }
        }
    }
}