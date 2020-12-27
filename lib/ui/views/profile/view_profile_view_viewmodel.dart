import 'package:flutter/material.dart';
import '../../../app/base_model.dart';
import '../../../services/authentication_service.dart';
import '../../../services/navigation_service.dart';
import '../../../services/dialog_service.dart';
import '../../../models/app_user.dart';
import '../../../app/service_locator.dart';

class ViewProfileViewModel extends BaseModel {
  //all services needed
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();

  AppUser currentAppUser;
  bool isNewAppUser=false;
  getModelReady() {
    currentAppUser = _authenticationService.currentAppUser;
    isNewAppUser = _authenticationService.isNewAppUser;
  }
}
