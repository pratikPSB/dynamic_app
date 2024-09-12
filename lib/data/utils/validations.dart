import 'package:vfs_dynamic_app/data/model/app_screens_model.dart';

String? validateEditText(String? value, Validation validation) {
  switch (validation.type) {
    case "email":
      return validateEmail(value, message: validation.errorMessage);
    case "mobile":
      return validateMobileNumber(7, 13, value, message: validation.errorMessage);
    case "password":
      return validatePassword(value, message: validation.errorMessage);
    default:
      return validateName(value, message: validation.errorMessage);
  }
}

String? validateName(String? value, {String? message}) {
  if (value == null || value.isEmpty) {
    return 'Required';
  }
  return null; // No error
}

String? validateEmail(String? value, {String? message}) {
  if (value == null || value.isEmpty) {
    return message ?? 'Email is required';
  }
  final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegExp.hasMatch(value)) {
    return message ?? 'Enter a valid email address';
  }
  return null; // No error
}

String? validatePassword(String? value, {String? message}) {
  if (value == null || value.isEmpty) {
    return message ?? 'Password is required';
  }
  final passwordRegExp =
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{1,}$');

  if (!passwordRegExp.hasMatch(value)) {
    return message ?? 'Password must contain at least one uppercase letter,\none lowercase letter, one number, and one \nspecial character';
  }
  return null; // No error
}

String? validateConfirmPassword(String? pass, String? confirmPass, {String? message}) {
  if (confirmPass == null || confirmPass.isEmpty) {
    return message ?? 'Password is required';
  } else if (pass != confirmPass) {
    return message ?? 'Password does not match';
  } else {
    return null;
  }
}

String? validateLength(int length, String? value, {String? message}) {
  if (value == null || value.isEmpty) {
    return message ?? 'Required';
  }
  if (value.length < length || value.length > length) {
    return message ?? 'Length must be $length characters long';
  }
  return null;
}

String? validateMobileNumber(int minLength, int maxLength, String? value, {String? message}) {
  if (value == null || value.isEmpty) {
    return message ?? 'Required';
  }
  if (value.length < minLength || value.length > maxLength) {
    return message ?? 'Please enter valid mobile number.';
  }
  return null;
}
