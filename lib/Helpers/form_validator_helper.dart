import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';


String? validator(String? value) {
  if (value!.isEmpty)
    return 'Please this field must be filled';
  else
    return null;
}

String? passValidator(String? value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$');

  if (value!.isEmpty)
    return 'Please this field must be filled';
  else if (value.length < 8)
    return 'Please enter minimum 8 chars';
  else if (!regex.hasMatch(value))
    return 'Use 1 uppercase,1 lowercase, 1 digit and 1 Special character';
  else
    return null;
}

String? confirmPassValidator(String? value) {
  RegExp regex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$');

  if (value!.isEmpty)
    return 'Please this field must be filled';
  else if (value.length < 8)
    return 'Please enter minimum 8 chars';
  else if (!regex.hasMatch(value))
    return 'Use 1 uppercase,1 lowercase, 1 digit and 1 Special character';
  else
    return null;
}

String? phoneValidator(String? value) {
  if (value!.isEmpty)
    return 'Please this field must be filled';
  else if (!value.isPhoneNumber)
    return 'Please enter a valid number';
  else
    return null;
}

String? numberValidator(String? value) {
  if (value!.isEmpty)
    return 'Please this field must be filled';
  else if (!value.isNumericOnly)
    return 'Please enter a number';
  else
    return null;
}

String? emailValidator(String? values) {
  if (values!.isEmpty)
    return "This field must be filled";
  else if (!GetUtils.isEmail(values.toString()))
    return "Please enter a valid email address";
  else
    return null;
}

/// Focus node
void fieldFocusChange(
    BuildContext context, FocusNode current, FocusNode nextFocus) {
  current.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
