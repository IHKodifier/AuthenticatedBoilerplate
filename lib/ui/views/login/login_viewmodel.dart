import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../services/authentication_service.dart';
import '../../../services/console_utility.dart';
import '../../../services/dialog_service.dart';
import '../../../services/navigation_service.dart';
import '../../../app/service_locator.dart';
import '../../../app/base_model.dart';
import '../../../app/route_paths.dart' as routes;
// import 'package:AuthenticatedBoilerplate/ui/views/home/home_view.dart';
import '../login/login_view.dart';

class LoginViewModel extends BaseModel {
 
 
  //all services needed
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();


//attempts to login a user into app , returns a [true] and navigates to [HomeViewRoute] if successfull or 
// return [false] navigates to [LoginViewRoute] if login fails
  Future<bool> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);
      notifyListeners();
    var loginSuccessfull = await _authenticationService.loginWithEmail(
        email: email, password: password);

    if (loginSuccessfull) {
      notifyListeners();
      // await _authenticationService.setAuthenticatedUser(uid)
      _navigationService.navigateTo(routes.HomeViewRoute);
      setBusy(false);
      return true;
    } else {
      _navigationService.popAndPush(routes.LoginRoute);
      setBusy(false);
      return false;
    }
  }

  

  Future showDialogFeatureNotReady() async {
    ConsoleUtility.printToConsole('dialog called');
    var dialogResult = await _dialogService.showDialog(
      title: 'Feature not ready yet!!',
      description: 'Come back some time later to enjoy this feature',
    );
    if (dialogResult.confirmed) {
      ConsoleUtility.printToConsole('User has confirmed');
    } else {
      ConsoleUtility.printToConsole('User cancelled the dialog');
    }
  }

  void navigateToSignup() {
    _navigationService.navigateTo(routes.SignUPViewRoute);
  }

  
}
