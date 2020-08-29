import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:AuthenticatedBoilerplate/app/route_paths.dart';
import 'package:AuthenticatedBoilerplate/app/service_locator.dart';
// import 'package:AuthenticatedBoilerplate/models/app_user.dart';
import 'package:AuthenticatedBoilerplate/services/authentication_service.dart';
import 'package:AuthenticatedBoilerplate/services/console_utility.dart';
import 'package:AuthenticatedBoilerplate/services/dialog_service.dart';
import 'package:AuthenticatedBoilerplate/services/navigation_service.dart';
//import 'package:AuthenticatedBoilerplate/ui/views/home/buyer_home_view.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/home/home_view.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/home/seller_home_view.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/login/login_view.dart';
import 'package:AuthenticatedBoilerplate/ui/views/welcome/welcome_view.dart';
import 'package:stacked/stacked.dart';
import 'package:AuthenticatedBoilerplate/app/route_paths.dart' as routes;

class StartupViewModel extends BaseViewModel {
  AuthenticationService _authenticationService = serviceLocator<AuthenticationService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();
  DialogService _dialogService = serviceLocator<DialogService>();

  void signOut() {
    _authenticationService.signout();
    _navigationService.navigateTo(routes.LoginRoute);
  }

  Future showDialog() async {
    ConsoleUtility.printToConsole('dialog called');
    var dialogResult = await _dialogService.showDialog(
      title: 'Loggin Successfull',
      description: 'FilledStacks architecture rocks',
    );
    if (dialogResult.confirmed) {
      ConsoleUtility.printToConsole('User has confirmed');
    } else {
      ConsoleUtility.printToConsole('User cancelled the dialog');
    }
  }


  Future resolveStartupLogin() async {
    setBusy(true);
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    notifyListeners();
    setBusy(false);
    if (hasLoggedInUser) {
      //  await  _authenticationService.setAuthenticatedUserFromFirestore();
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(WelcomeRoute);
    }
  }

  String _title = 'Startup View Model Widget';
  String get title => _title;
}
