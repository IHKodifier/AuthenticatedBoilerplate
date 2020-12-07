
import '../../../app/base_model.dart';
import '../../../app/service_locator.dart';
import '../../../services/authentication_service.dart';
import '../../../services/dialog_service.dart';
import '../../../services/navigation_service.dart';
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