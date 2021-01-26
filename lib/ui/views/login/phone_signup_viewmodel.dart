import 'package:AuthenticatedBoilerPlate/app/service_locator.dart';
import 'package:AuthenticatedBoilerPlate/services/authentication_service.dart';
import 'package:AuthenticatedBoilerPlate/services/navigation_service.dart';
import 'package:AuthenticatedBoilerPlate/services/dialog_service.dart';
import '../../../services/console_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../app/route_paths.dart' as routes;
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/base_model.dart';

class PhoneSignupViewModel extends BaseModel {
  //all services needed
  AuthenticationService _authService = serviceLocator<AuthenticationService>();

  DialogService _dialogService = serviceLocator<DialogService>();
  NavigationService _navigationService = serviceLocator<NavigationService>();
  AuthenticationService get authService => _authService;
  String phoneNumber;
  String verificationId;
  String otp;

  Future<void> verifyPhone(String phoneNmber) async {
    // setBusy(true);
    notifyListeners();
    this.phoneNumber = phoneNmber;
    ConsoleUtility.printToConsole(
        'Model will attempt to verify  phone number ${this.phoneNumber}');
    await _authService.authInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 3),
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _handleCodeSent,
        codeAutoRetrievalTimeout: _autoTimeOut);
  }

  void _verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
    ConsoleUtility.printToConsole(
        // TODO
        'looks like phone verifiction met success\n this is the auth credential\n${phoneAuthCredential.toString()}');
    setBusy(false);
    _authService.authInstance
        .signInWithCredential(phoneAuthCredential)
        .then((value) {
      // if (value.user != null)
      //   _navigationService.navigateTo(routes.HomeViewRoute);
      _authService.handleCredentialSuccess(
          userCredential: value, providerId: 'Phone');
    });
  }

  _handleCodeSent(String verId, [int forceCodeResend]) {
    ConsoleUtility.printToConsole('you otp has been sent ');
    this.verificationId = verId;
    notifyListeners();
  }

  _verificationFailed(FirebaseAuthException exception) {
    setBusy(false);
    // TODO implement this.
    _dialogService.showDialog(
        title: 'Error encountered', description: exception.message);
    ConsoleUtility.printToConsole(exception.message);
  }

  PhoneCodeAutoRetrievalTimeout _autoTimeOut(String verId) {
    ConsoleUtility.printToConsole('Auto validation of OTP has did not succeed');

    this.verificationId = verId;
    setBusy(false);
    notifyListeners();
  }

  FirebaseAuth get authInstace => _authService.authInstance;

  signInWithCredential(AuthCredential authCredential) async {
    final result = await authInstace.signInWithCredential(authCredential);
    if (result.user != null) {
      ConsoleUtility.printToConsole('USER SUCCESSFULLY LOGGED IN ');
      _navigationService.navigateTo(routes.HomeViewRoute);
      // _authService.signou
    } else {}
    setBusy(false);
    return result;
  }

  void initModel() {
    // authInstace.setting
  }
}
