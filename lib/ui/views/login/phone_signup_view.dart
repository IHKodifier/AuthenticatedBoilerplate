import 'package:AuthenticatedBoilerPlate/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
// import 'package:international_phone_input/international_phone_input.dart';
import '../login/phone_signup_viewmodel.dart';
import '../../../services/dialog_service.dart';
import '../../../app/service_locator.dart';
import '../../../services/console_utility.dart';
// import 'dart:convert';

class PhoneSignupView extends StatelessWidget {
  String phoneNumber;
  String otp;
  // String verificationId;
  TextEditingController smsTextEditingController = TextEditingController();
  TextEditingController phonNumberEditingController = TextEditingController();

  final DialogService dialogService = serviceLocator<DialogService>();
  // AuthenticationService _authService = serviceLocator<AuthenticationService>();
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PhoneSignupViewModel>.reactive(
      viewModelBuilder: () => PhoneSignupViewModel(),
      // onModelReady: (model) => model.initModel(),
      builder: (builder, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).primaryColor),
          title: Text(
            'Sign up with Phone Number',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.25),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: phonNumberEditingController,
                    decoration: InputDecoration(
                      hintText: ' example   +92 333 5560 321',
                      labelText: 'Enter phone number',
                    ),
                    keyboardType: TextInputType.phone,
                    onSubmitted: (String value) {
                      this.phoneNumber = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    child: RaisedButton(
                      onPressed: () {
                        model.verifyPhone(this.phoneNumber);
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Verify Phone',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        '1==>\t\t\t We will send a 6 digit code on above Phone Number to verify your access to  above phone ',
                        style: Theme.of(context).textTheme.caption),
                  ),
                  //  Padding(
                  //    padding: const EdgeInsets.all(16),
                  //    child: Text('2==>\t\t\t We will try to auto validate the code if number is active on this device',
                  //    style: Theme.of(context).textTheme.caption),
                  //  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        '2==>\t\t\t If Auto validation fails, enter the 6 Digit code below and press subit',
                        style: Theme.of(context).textTheme.caption),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  smsTextField(model, context),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    child: Text(
                      'submit OTP',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.white),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      // dialogService.
                      model.notifyListeners();
                      ConsoleUtility.printToConsole(
                          'the OTP enetered was ${model.otp}');
                      AuthCredential authCredential =
                          PhoneAuthProvider.credential(
                              verificationId: model.verificationId,
                              smsCode: model.otp);
                      model.signInWithCredential(authCredential);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  smsTextField(PhoneSignupViewModel model, BuildContext context) {
    return Container(
      // height: 200,
      // color: Theme.of(context).primaryColor.withOpacity(0.25),
      child: Column(
        children: [
          // model.isBusy ? CircularProgressIndicator() : Container(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: TextField(
              controller: smsTextEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter OTP', labelText: '6 Digit OTP code '),
              onChanged: (String value) {
                model.otp = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  initModel() {
// TODO
    // fetchCountryData(context, 'countries.json');
  }
}





  // static Future<List<Country>> fetchCountryData(
  //     BuildContext context, String jsonFile) async {
  //   var list = await DefaultAssetBundle.of(context).loadString(jsonFile);
  //   List<Country> elements = [];
  //   var jsonList = json.decode(list);
  //   jsonList.forEach((s) {
  //     Map elem = Map.from(s);
  //     elements.add(Country(
  //         name: elem['en_short_name'],
  //         code: elem['alpha_2_code'],
  //         dialCode: elem['dial_code'],
  //         flagUri: 'assets/flags/${elem['alpha_2_code'].toLowerCase()}.png'));
  //   });
  //   return elements;
  // }

// class Country {
//   final String name;

//   final String flagUri;

//   final String code;

//   final String dialCode;

//   Country({this.name, this.code, this.flagUri, this.dialCode});

