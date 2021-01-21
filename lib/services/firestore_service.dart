/// # region imports
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/service_locator.dart';
import '../models/app_user.dart';
import '../services/console_utility.dart';
import '../services/dialog_service.dart';

/// endregion

/// # region ClassInfo
final String className = 'FirestoreService';
final String _version = '1.0.0';
final String _packageName = 'AuthenticatedBoilerPlate';

/// endregion

/// this class wraps all the functionality required by an App to write/retrive update documents to firestore database
/// Singleton instance of this class is available across the  App  and get can be refernced by
/// instantiating an [[AuthenticationService]] via call to serviceLocator. syntax below
/// /// final AuthenticationService _authService =serviceLocator<AuthenticationService>();
///
///

class FirestoreService {
  final DialogService dialogService = serviceLocator<DialogService>();

  CollectionReference _usercollectionReference =
      FirebaseFirestore.instance.collection('appUsers');

  Future<bool> createAppUserDoc(
      {
      // AuthResult authResult,
      // var userProfileData,
      AppUser appUser,
      bool merge = true}) async {
    try {
      await _usercollectionReference.doc(appUser.email).set(appUser.toJson());
      ConsoleUtility.printToConsole(
          'created Appuser in Firestore\n${appUser.toJson().toString()}');
    } catch (e) {
      ConsoleUtility.printToConsole(
          'Firestore service\n createUserProfile\nerror encountered: \n${e.toString()}');
      dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    }
  }
}
