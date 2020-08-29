import 'package:AuthenticatedBoilerplate/ui/shared/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_button.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_input_field.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_password_field.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/busy_overlay.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/busy_overlayBuilder.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/loding_spinner.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/home/home_view.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/already_have_an_account.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/components/background.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/components/body.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  //text controllers and fields
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  BuildContext _localContext;

  @override
  Widget build(BuildContext context) {
    this._localContext = context;
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, child) =>
            _buildLoginScaffold(context, model));
  }

  Widget _buildLoginScaffold(BuildContext context, LoginViewModel model) {
    return BusyOverlayBuilder(
      title: 'Loading',
      busyValue: model.isBusy,
      childWhenIdle: Scaffold(
        body: _buildBody(context, model),
      ),
    );
  }

  _buildBody(BuildContext context, LoginViewModel model) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.30,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                textEditingController: _emailController,
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                textEditingController: _passwordController,
                // obscureText: true,
                onChanged: (value) {},
              ),
              RoundedButton(
                color: Theme.of(context).primaryColor,
                text: "LOGIN",
                press: () {
                  model.setBusy(true);
                  model.loginWithEmail(
                      email: _emailController.text,
                      password: _passwordController.text);
                  // model.setBusy(false);
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  model.navigateToSignup();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
