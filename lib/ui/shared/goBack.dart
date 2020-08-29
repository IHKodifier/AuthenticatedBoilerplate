

import 'rounded_button.dart';
import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  final Function onPress;
  const GoBackButton({
    Key key, 
    this.onPress, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.0,
        child: Container(
          child: RoundedButton(
            color: Theme.of(context).primaryColorLight,
            press: this.onPress,
            textColor: Theme.of(context).primaryColor,
            text: 'Go Back',
          ),
        ));
  }
}