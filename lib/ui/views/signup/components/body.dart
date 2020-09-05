import 'package:flutter/material.dart';
import 'package:AuthenticatedBoilerplate/ui/views/Login/login_view.dart';
import 'package:AuthenticatedBoilerplate/ui/views/Signup/components/background.dart';
import '../../../shared/or_divider.dart';
import 'package:AuthenticatedBoilerplate/ui/views/Signup/components/social_icon.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/already_have_an_account.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_button.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_input_field.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      // return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SocialIcon(
                //   iconSrc: "assets/icons/facebook.svg",
                //   press: () {},
                // ),
                // SocialIcon(
                //   iconSrc: "assets/icons/twitter.svg",
                //   press: () {},
                // ),
                // SocialIcon(
                //   iconSrc: "assets/icons/google-plus.svg",
                //   press: () {},
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}