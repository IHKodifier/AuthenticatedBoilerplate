import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/service_locator.dart';
import '../models/app_user.dart';
import '../services/console_utility.dart';
import '../services/dialog_service.dart';

class FirestoreService {
  final DialogService dialogService = serviceLocator<DialogService>();

  final CollectionReference _usercollectionReference =
      Firestore.instance.collection('appUsers');

  Future<bool> createAppUser(
    // AuthResult authResult,
    // var userProfileData,
    AppUser appUser,
  ) async {
    try {
      await _usercollectionReference
          .doc(appUser.email)
          .set(appUser.toJson());
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
