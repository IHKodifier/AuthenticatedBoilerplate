import 'package:AuthenticatedBoilerPlate/app/service_locator.dart';
import 'package:AuthenticatedBoilerPlate/services/authentication_service.dart';

import '../../../../app/size_config.dart';
import '../../../shared/social_card.dart';
import '../../../views/login/components/login_form.dart';
import 'package:flutter/material.dart';
import '../../../../app/constants.dart';
import '../components/login_form.dart';

class Body extends StatelessWidget {
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: _authenticationService.signInWithGoogle
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: _authenticationService.signInWithFacebook,
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                      press: _authenticationService.signInWithTwitter,
                      
                    ),
                    SocialCard(
                      icon: "assets/icons/SIMCard.svg",
                      press: _authenticationService.signInWithPhoneNumber,

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
