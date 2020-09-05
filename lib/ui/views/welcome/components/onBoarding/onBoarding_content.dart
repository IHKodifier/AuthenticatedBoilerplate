import 'package:flutter/material.dart';

// import '../../../../../app/constants.dart';
// import '../../../size_config.dart';

class onBoaringPageView extends StatelessWidget {
  const onBoaringPageView({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    // var _mediaQuer
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        
        Spacer(flex: 2),
        Text(
          "B2B Express",
          style:Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
        Spacer(),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        
        Spacer(),
        Image.asset(
          image,
          width: MediaQuery.of(context).size.width*.70,
          // getProportionateScreenHeight(265),
          // width: 
          // getProportionateScreenWidth(235),
        ),
        // Spacer(),
      ],
    );
  }
}