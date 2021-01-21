import 'package:AuthenticatedBoilerPlate/app/service_locator.dart';
import 'package:AuthenticatedBoilerPlate/services/authentication_service.dart';
import 'package:AuthenticatedBoilerPlate/services/navigation_service.dart';
import 'package:AuthenticatedBoilerPlate/ui/views/login/login_viewmodel.dart';
import '../../../../app/route_paths.dart' as routes;

import '../../../shared/social_card.dart';
import '../../../views/login/components/login_form.dart';
import 'package:flutter/material.dart';
import '../../../../app/constants.dart';
import '../components/login_form.dart';

class Body extends StatelessWidget {
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  final NavigationService navigationService =
      serviceLocator<NavigationService>();
  final LoginViewModel model;

  Body({Key key, this.model}) : super(key: key);
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
                LoginForm(
                  model: model,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {
                          model.setBusy(true);
                          _authenticationService.signInWithGoogle();
                          model.setBusy(false);
                        }),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: _authenticationService.signInWithFacebook,
                    ),
                    // SocialCard(
                    //   icon: "assets/icons/twitter.svg",
                    //   press: _authenticationService.signInWithTwitter,
                    // ),
                    SocialCard(
                        icon: "assets/icons/SIMCard.svg",
                        press: () {
                          navigationService
                              .navigateTo(routes.PhoneSignupViewRoute);
                        }),
                  ],
                ),
                SizedBox(height: 30),
                buildSignupInvite(context),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignupInvite(BuildContext context) {
return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don’t have an Account ? " ,
          style: TextStyle(color: Colors.black87),
        ),
        GestureDetector(
          onTap: model.navigateToSignup,
          child: Text(
             "Sign Up" ,
            style: TextStyle(
              color: appPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );


  }
}
