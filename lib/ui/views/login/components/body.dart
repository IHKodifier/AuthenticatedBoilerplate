import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_button.dart';
// import 'package:AuthenticatedBoilerplate/app/rounded_input_field.dart' as inputField;
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_input_field.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_password_field.dart';
import 'package:AuthenticatedBoilerplate/app/service_locator.dart';
import 'package:AuthenticatedBoilerplate/services/authentication_service.dart';
import 'package:AuthenticatedBoilerplate/services/navigation_service.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/already_have_an_account.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/components/background.dart';
// import 'package:flutter/material.dart';

class Body extends StatelessWidget {
   Body({
    Key key,
  }) : super(key: key);
  final AuthenticationService authenticationService =
      serviceLocator<AuthenticationService>();
  final NavigationService navigationService =
      serviceLocator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              color: Theme.of(context).primaryColor,
              text: "LOGIN",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      // return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
