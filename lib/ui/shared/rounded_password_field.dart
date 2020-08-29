import 'package:flutter/material.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/text_field_container.dart';
import 'package:AuthenticatedBoilerplate/app/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  RoundedPasswordField({
    Key key,
    this.onChanged,
    this.textEditingController,
    // this.obscureText,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool passwordIsHidden = true;



  void togglePasswordVisibility() {
    setState(() {
      passwordIsHidden = !passwordIsHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.textEditingController,
        obscureText: passwordIsHidden,
        onChanged: widget.onChanged,
        cursorColor: appPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: appPrimaryColor,
          ),
          suffixIcon: IconButton(
              color: appPrimaryColor,
              onPressed: togglePasswordVisibility,
              icon: Icon(
                Icons.visibility,
              )),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
