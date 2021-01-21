import 'package:AuthenticatedBoilerPlate/services/console_utility.dart';
import 'package:flutter/material.dart';
import '../../../app/base_model.dart';
import '../../../services/authentication_service.dart';
import '../../../services/navigation_service.dart';
import '../../../services/dialog_service.dart';
import '../../../models/app_user.dart';
import '../../../app/service_locator.dart';
import '../../../app/route_paths.dart' as routes;

class ViewProfileViewModel extends BaseModel {
  //all services needed
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();

  AppUser currentAppUser;
  bool isNewAppUser = false;
  String photoURL;
  getModelReady() {
    currentAppUser = _authenticationService.currentAppUser;
    isNewAppUser = _authenticationService.isNewAppUser;
    photoURL = currentAppUser.photoURL;
  }

  Future signout() async {
    await _authenticationService.signout();
    ConsoleUtility.printToConsole('Signout successfully ');
    currentAppUser = null;
    isNewAppUser = false;
    ConsoleUtility.printToConsole(
        'currentAppUser set to null \nisnewAppUser sert to false');
    _navigationService.popAndPush(routes.LoginRoute);
  }

  navigateToUserHome() {
    _navigationService.navigateTo('HomeViewRoute');
  }
}
