String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Required';
  }
  return null; // No error
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegExp.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null; // No error
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  final passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{1,}$');

  if (!passwordRegExp.hasMatch(value)) {
    return 'Password must contain at least one uppercase letter,\none lowercase letter, one number, and one \nspecial character';
  }
  return null; // No error
}

String? validateConfirmPassword(String? pass, String? confirmPass) {
  if (confirmPass == null || confirmPass.isEmpty) {
    return 'Password is required';
  } else if (pass != confirmPass) {
    return 'Password does not match';
  } else {
    return null;
  }
}

String? validateLength(int length, String? value) {
  if (value == null || value.isEmpty) {
    return 'Required';
  }
  if (value.length < length || value.length > length) {
    return 'Length must be $length characters long';
  }
  return null;
}
