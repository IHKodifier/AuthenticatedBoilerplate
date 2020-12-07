import '../../../services/console_utility.dart';
import '../../shared/busy_overlayBuilder.dart';
import '../welcome/welcome_viewmdel.dart';
import 'package:stacked/stacked.dart';
import '../../../app/constants.dart';
import '../../shared/default_button.dart';

import '../../../app/constants.dart';

import '../../../app/size_config.dart';
import 'package:flutter/material.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/welcome/components/body.dart';

import 'components/onBoarding/onBoarding_content.dart';
import 'components/onBoarding/onBoarding_data.dart';
import '../../../app/route_paths.dart' as routes;

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => WelcomeViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => onBoaringPageView(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    // horizontal: getProportionateScreenWidth(20),
                    horizontal: 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(flex: 3),
                      DefaultButton(
                        text: "Continue",
                        press: () {
                          Navigator.pushNamed(context, routes.LoginRoute);
                          ConsoleUtility.printToConsole('click not working');

                          //TODO: Navigator.pushNamed(context, SignInScreen.routeName);
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 5,
      width: currentPage == index ? 30 : 10,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).primaryColor
            : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
