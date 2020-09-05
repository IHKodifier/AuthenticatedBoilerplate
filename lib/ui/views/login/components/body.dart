import 'package:AuthenticatedBoilerplate/app/size_config.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/social_card.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/components/login_form.dart';
import 'package:flutter/material.dart';
// import 'package:shop_app/components/no_account_text.dart';
// import 'package:shop_app/components/social_card.dart';
// import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';

import '../../../../app/constants.dart';
import '../../../../app/size_config.dart';
import '../components/login_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Sign in with your email and password  \nor continue with social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                LoginForm(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // NoAccountText(,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
