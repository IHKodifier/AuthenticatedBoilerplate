import 'package:AuthenticatedBoilerPlate/app/base_model.dart';
import 'package:AuthenticatedBoilerPlate/app/service_locator.dart';
import 'package:AuthenticatedBoilerPlate/services/authentication_service.dart';
import 'package:AuthenticatedBoilerPlate/services/navigation_service.dart';
import 'package:AuthenticatedBoilerPlate/services/dialog_service.dart';
import '../../../services/console_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../app/route_paths.dart' as routes;
import 'package:firebase_auth/firebase_auth.dart';

class HomeViewModel extends BaseModel {
  AuthenticationService _authService = serviceLocator<AuthenticationService>();

  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();

  void signOut() {
    _authService.signout();
    _navigationService.popAndPush(routes.LoginRoute);
  }
}
