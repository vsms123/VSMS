console.log("Form validation js is here");
// When the browser is ready...
$(function() {

    // Setup form validation for adding the dish
    $("#addDish").validate({
//        Specify the error and valid styling (red color if error, green color if valid)
        errorClass: "my-error-class",
        validClass: "my-valid-class",
        // Specify the validation rules
        rules: {
            dish_name: "required",
            dish_description: "required",
        },
        // Specify the validation error messages
        messages: {
            firstname: "Please enter your dish name",
            lastname: "Please enter your dish description",
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
// Setup form validation for adding the ingredient
    $("#addIngredient").validate({
//        Specify the error and valid styling (red color if error, green color if valid)
        errorClass: "my-error-class",
        validClass: "my-valid-class",
        // Specify the validation rules
        rules: {
            name: "required",
            subcategory: "required",
            quantity: {
                required: true,
                number: true
            },
            supplyUnit: "required",
            description: "required",
            offeredPrice: {
                required: true,
                number: true
            },
        },
        // Specify the validation error messages
        messages: {
            name: "Please enter a valid ingredient name",
            subcategory: "Please enter a valid sub category",
            quantity: "Please enter the correct quantity, number is required",
            supplyUnit: "Please enter the correct unit",
            description: "Please enter the correct description",
            offeredPrice: "Please enter a valid price, number is required",
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
    // Setup form validation for adding the ingredient
    $("#addOrder").validate({
//        Specify the error and valid styling (red color if error, green color if valid)
        errorClass: "my-error-class",
        validClass: "my-valid-class",
        // Specify the validation rules
        rules: {
            name: "required",
            subcategory: "required",
            quantity: {
                required: true,
                number: true
            },
            supplyUnit: "required",
            description: "required",
            offeredPrice: {
                required: true,
                number: true
            },
        },
        // Specify the validation error messages
        messages: {
            name: "Please enter a valid ingredient name",
            subcategory: "Please enter a valid sub category",
            quantity: "Please enter the correct quantity, number is required",
            supplyUnit: "Please enter the correct unit",
            description: "Please enter the correct description",
            offeredPrice: "Please enter a valid price, number is required",
        },
        submitHandler: function(form) {
            form.submit();
        }
    });

    // Setup form validation for logging in
    $("#login").validate({
//        Specify the error and valid styling (red color if error, green color if valid)
        onfocusout: false,
        onkeyup: false,
        onclick: false,
        onsubmit: true,
        errorPlacement: function(error, element) {
            alert(error.text());
        },
        errorClass: "my-error-class",
        validClass: "my-valid-class",
        // Specify the validation rules
        rules: {
            username: "required",
            password: "required",
        },
        // Specify the validation error messages
        messages: {
            username: "Please enter a valid username",
            password: "Please enter a valid password",
        },
        submitHandler: function(form) {
            form.submit();
        }
    });

// Setup form validation for editing profile
    $("#editProfile").validate({
//        Specify the error and valid styling (red color if error, green color if valid)
        errorClass: "my-error-class",
        validClass: "my-valid-class",
        // Specify the validation rules
        rules: {
            email: {
                required: true,
                email: true
            },
            address: "required",
            area_code: {
                required: true,
                number: true
            },
            telephone_number: {
                required: true,
                number: true
            },
            vendor_description: "required",
        },
        // Specify the validation error messages
        messages: {
            email: "Please enter a valid email",
            address: "Please enter a valid address",
            area_code: "Please enter a valid area code where number is required",
            telephone_number: "Please enter valid telephone number where number is required",
            vendor_description: "Please enter the correct description",
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
    // Setup form validation for editing profile
    $("#editPassword").validate({
//        Specify the error and valid styling (red color if error, green color if valid)
        errorClass: "my-error-class",
        validClass: "my-valid-class",
        // Specify the validation rules
        rules: {
            old_password: "required",
            new_password: "required",
            new2_password: {
                equalTo: "#new_password"
            }
        },
        // Specify the validation error messages
        messages: {
            old_password: "Please enter your old password properly",
            new_password: "Please enter your new password",
            new2_password: "Please enter the same password as your New Password",
        },
        submitHandler: function(form) {
            form.submit();
        }
    });
});