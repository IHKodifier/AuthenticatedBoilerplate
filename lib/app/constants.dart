import 'package:flutter/material.dart';

// const appPrimaryColor = Color(0xFF6F35A8);
const appPrimaryColor= Colors.deepOrange;
const appPrimaryLightColor = Color(0xFFF1E6FF);
const appAccentColor = Colors.deepOrangeAccent;
const appScaffoldBackgroundColor = Colors.white;
const kAnimationDuration = Duration(milliseconds: 200);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: 50
      // getProportionateScreenWidth(15)
      ),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(50
    // getProportionateScreenWidth(15)
    ),
    borderSide: BorderSide(color: appPrimaryColor),
  );
}