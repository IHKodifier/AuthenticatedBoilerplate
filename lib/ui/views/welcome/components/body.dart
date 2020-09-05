import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../shared/rounded_button.dart';
import '../../login/login_view.dart';
import '../../signup/signup_view.dart';
import '../../welcome/components/background.dart';
import '../../../../app/constants.dart' as constants;

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Text(
          "B2B Express",
          style: TextStyle(
            // fontSize: getProportionateScreenWidth(36),
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:4.0),
              child: Text(
                "Authenticated BoilerPlate",
                style:Theme.of(context).textTheme.headline5.copyWith( 
                // TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 64.0,right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   'Your ONE AND ONLY  Online stop for Business to Business Procurements',
                  //   style: Theme.of(context).textTheme.subtitle1.copyWith(
                  //       color: Theme.of(context).primaryColor,
                  //       fontStyle: FontStyle.italic),
                  // ),
                  
                ],
              ),
            ),
            // SizedBox(height: size.height * 0.04),
            // SvgPicture.asset(
            //   "assets/icons/chat.svg",
            //   height: size.height * 0.30,
            // ),
            SizedBox(height: size.height * 0.04),
            RoundedButton(
              color: constants.appPrimaryColor,
              text: "LOGIN",
              press: () {
                // todo use navigation service
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginView();
                    },
                  ),
                );
                
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              // todo replace with theme based color
              color: constants.appPrimaryLightColor,
              textColor: constants.appPrimaryColor,
              // Colors.black,
              press: () {
                // todo use navigation service
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupView();
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all( 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('powered by  EnigmaTek Inc.',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontStyle: FontStyle.italic
                          )),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
