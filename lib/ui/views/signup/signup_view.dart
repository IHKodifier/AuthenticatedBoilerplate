import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/rounded_button.dart';
import '../../shared/rounded_input_field.dart';

import '../../shared/busy_overlayBuilder.dart';

import '../../shared/ui_helpers.dart';
import '../../shared/or_divider.dart';
// import './components/social_icon.dart';
import './signup_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../shared/rounded_password_field.dart';
import '../../shared/goBack.dart';
import '../../shared/social_card.dart';

  class SignupView extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _profileTitleController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  Map<String, dynamic> userData = Map<String, dynamic>();

//handles the user related additional data

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
        builder: (context, model, child) =>
            _buildSingleChildScrollView(context, model),
        viewModelBuilder: () => SignupViewModel());
  }

  Widget _buildSingleChildScrollView(
      BuildContext context, SignupViewModel model) {
    Size size = MediaQuery.of(context).size;
    return BusyOverlayBuilder(
      busyValue: model.isBusy,
      title: 'Loading',
      childWhenIdle: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Sign up'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 100,
                  child: _buildStack(context),
                ),
                Container(
                    padding: EdgeInsets.only(top: 5, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                    
                        Image.asset('assets/images/signup.png',
                        height: 140,),
                        SizedBox(height: 20.0),
                        
                        _emailTextField(context),
                        _passwordTextField(context),
                        
                        verticalSpaceSmall,
                        _disclaimer(context),
                        verticalSpaceSmall,
                        _signUpButton(context, model),
                        _goBackButton(context, model),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Row _socialIcons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       SocialIcon(
  //         iconSrc: "assets/icons/google-plus.svg",
  //         press: () {},
  //       ),
  //       SocialIcon(
  //         iconSrc: "assets/icons/facebook.svg",
  //         press: () {},
  //       ),
  //       SocialIcon(
  //         iconSrc: "assets/icons/twitter.svg",
  //         press: () {},
  //       ),
  //     ],
  //   );
  // }

  GoBackButton _goBackButton(BuildContext context, SignupViewModel model) {
    return GoBackButton(onPress: () {
      model.goBack();
    });
  }

  Container _signUpButton(BuildContext context, SignupViewModel model) {
    return Container(
      height: 80.0,
      child: RoundedButton(
        color: Theme.of(context).primaryColor,
        press: () {
          //todo implement service based navigation
          model.setBusy(true);
          // userData['profileTitle'] = _profileTitleController.text;
          // userData['fullName'] = _fullNameController.text;
          // userData['email'] = _emailController.text;

          model.signupWithEmil(
            _emailController.text,
            _passwordController.text,
            // userData,
          );
        },
        text: 'SIGNUP',
      ),
    );
  }

  RoundedInputField _rofileTitleTextField(BuildContext context) {
    return RoundedInputField(
      textEditingController: _profileTitleController,
      hintText: 'Choose a Profile Title',
    );
  }

  RoundedPasswordField _passwordTextField(BuildContext context) {
    return RoundedPasswordField(
      textEditingController: _passwordController,
    );
  }

  RoundedInputField _emailTextField(BuildContext context) {
    return RoundedInputField(
      textEditingController: _emailController,
      hintText: 'Email',
    );
  }

  RoundedInputField _fullNameTextField(BuildContext context) {
    return RoundedInputField(
      textEditingController: _fullNameController,
      hintText: 'Full Name',
    );
  }

  Widget _toggleButtons(
      BuildContext context, SignupViewModel model) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        color: Theme.of(context).primaryColorLight.withAlpha(240),
        // elevation: 2,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I am a  potential ',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildToggleButtons(context, model),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButtons(BuildContext context, SignupViewModel model) {
    return Container(
      child: ToggleButtons(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Text(
                  'Buyer',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                FaIcon(
                  FontAwesomeIcons.cartArrowDown,
                  size: 50,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Text(
                  'Seller',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                FaIcon(
                  FontAwesomeIcons.truck,
                  size: 45,
                ),
              ],
            ),
          ),
        ],
        isSelected: model.roleSelectionValues,
        onPressed: (index) {
          bool value = model.roleSelectionValues[index];
          model.setToggleButtonSelectionValueAt(!value, index);
        },
        selectedColor: Theme.of(context).primaryColor,
        color: Colors.black,
        renderBorder: false,
        splashColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildStack(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Signup',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }

  _disclaimer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
          'By Tapping the Sign up  button you are excepting our License Agreement',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic,
              )),
    );
  }
}
