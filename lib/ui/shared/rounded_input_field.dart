import 'package:flutter/material.dart';


import '../../ui/shared/text_field_container.dart' as tfc;
// import 'package:AuthenticatedBoilerplate/app/text_field_container.dart';
import '../../app/constants.dart' as consts;

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged, this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tfc.TextFieldContainer(
      child: TextField(
        controller: textEditingController,
        onChanged: onChanged,
        cursorColor: consts.appPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: consts.appPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
