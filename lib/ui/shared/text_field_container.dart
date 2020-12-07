import 'package:flutter/material.dart';
import '../../app/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: appPrimaryLightColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }
}