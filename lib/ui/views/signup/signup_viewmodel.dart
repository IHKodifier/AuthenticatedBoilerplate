import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/service_locator.dart';
import '../../../app/base_model.dart';
import '../../../services/authentication_service.dart';
import '../../../services/console_utility.dart';
import '../../../services/dialog_service.dart';
import '../../../services/navigation_service.dart';
import '../../../app/route_paths.dart' as routes;

class SignupViewModel extends BaseModel {
  //services
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();

  //captures the state of toggle buttons
  List<bool> roleSelectionValues = [false, false];

  //role handling
  String selectedRole;
  // boll passwordVisibility = false;
  List<String> roles = ['Buyer', 'Seller'];
//user info and profile data
  Map<String, dynamic> userData;

  //set value of [togglebutton] at index
  void setToggleButtonSelectionValueAt(bool value, int index) {
    resetAllToggleButtons();
    roleSelectionValues[index] = value;
    selectedRole = roles[index];
    notifyListeners();
  }

//reset all togglebuttons to false
  void resetAllToggleButtons() {
    for (int i = 0; i < roleSelectionValues.length; i++) {
      roleSelectionValues[i] = false;
    }
  }

  Future login({@required String email, @required String password}) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo('HomeViewRoute');
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'Couldn\'t login at this moment. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result.toString(),
      );
    }
  }

  Future<dynamic> signupWithEmil(
    String email,
    String password,
    var userData,
  ) async {
    setBusy(true);
    userData['roles'] = selectedRole;
    try {
      var SignupResult = await _authenticationService.signupWithEmail(
          email: email, password: password, userData: userData);
      setBusy(false);

      if (SignupResult != null) {
        //user was SUCCESSFULLY CREATED in Firbase
        _navigationService.popAndPush(routes.NewAccountSuccessRoute);
      } else if (SignupResult == null) {
        //user was not successfully created
        ConsoleUtility.printToConsole('user sign up failed');
      } else {}
    } catch (e) {
      setBusy(false);
      ConsoleUtility.printToConsole(e.toString());
    }
  }

  void goBack() {
    _navigationService.goBack();
  }

  togglePasswordVisibility() {
    notifyListeners();
  }
}
