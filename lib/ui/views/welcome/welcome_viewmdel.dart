import 'package:AuthenticatedBoilerplate/app/base_model.dart';
import 'package:AuthenticatedBoilerplate/app/service_locator.dart';
import 'package:AuthenticatedBoilerplate/services/authentication_service.dart';
import 'package:AuthenticatedBoilerplate/services/dialog_service.dart';
import 'package:AuthenticatedBoilerplate/services/navigation_service.dart';
import '../../../app/route_paths.dart' as routes;

class WelcomeViewModel extends BaseModel {
  //all services needed
  AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();
  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();



   void navigateToLogin() {
    _navigationService.navigateTo(routes.LoginRoute);
  }
  
}