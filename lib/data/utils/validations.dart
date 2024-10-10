import 'package:vfs_dynamic_app/data/model/app_modules_by_client_model.dart';

import '../../main.dart';

String? validateEditText(String? value, Validations validation) {
  if (_validateMandatory(validation.mandatory, value) != null) {
    return _validateMandatory(validation.mandatory, value);
  } else if (_validateLength(validation.maxLength, value, isForMin: false) != null) {
    return _validateLength(validation.maxLength, value, isForMin: false);
  } else if (_validateLength(validation.minLength, value, isForMin: true) != null) {
    return _validateLength(validation.minLength, value, isForMin: true);
  } else if (_validateValue(validation.regex, value) != null) {
    return _validateValue(validation.regex, value);
  } else if (_validateValue(validation.maxValue, value) != null) {
    return _validateValue(validation.maxValue, value);
  } else if (_validateValue(validation.minValue, value) != null) {
    return _validateValue(validation.minValue, value);
  } else if (validateDateTime(validation.validateDateTime, value) != null) {
    return validateDateTime(validation.validateDateTime, value);
  } else {
    return null;
  }
}

String? validateDateTime(ValidateDateTime? validateDateTime, String? value) {
  return null;
}

String? _validateValue(MaxValue? regex, String? value) {
  if (regex != null) {
    if (regex.value != null) {
      try {
        final regExp = RegExp(regex.value!);
        if (!regExp.hasMatch(value!)) {
          return appStringMap[regex.message] ?? regex.message!;
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  } else {
    return null;
  }
}

String? _validateMandatory(Mandatory? mandatory, String? value) {
  if (mandatory != null) {
    if (mandatory.value != null) {
      if (mandatory.value is bool) {
        if (mandatory.value) {
          if (value!.isEmpty) {
            return appStringMap[mandatory.message] ?? mandatory.message!;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  } else {
    return null;
  }
}

String? _validateLength(Length? regex, String? value, {bool? isForMin}) {
  if (regex != null) {
    if (regex.value != null) {
      if (regex.value is int) {
        return _checkMinMaxLength(
            regex.value!, appStringMap[regex.message] ?? regex.message!, value, isForMin);
      } else if (int.tryParse(regex.value!) != null) {
        return _checkMinMaxLength(int.parse(regex.value!),
            appStringMap[regex.message] ?? regex.message!, value, isForMin);
      } else {
        return null;
      }
    } else {
      return null;
    }
  } else {
    return null;
  }
}

String? _checkMinMaxLength(int length, String message, String? value, bool? isForMin) {
  if (isForMin != null) {
    if (isForMin) {
      if (value!.length < length) {
        return message;
      } else {
        return null;
      }
    } else {
      if (value!.length > length) {
        return message;
      } else {
        return null;
      }
    }
  } else {
    return null;
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
    return message ??
        'Password must contain at least one uppercase letter,\none lowercase letter, one number, and one \nspecial character';
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
