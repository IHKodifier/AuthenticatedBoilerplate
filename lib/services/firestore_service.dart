import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/service_locator.dart';
import '../models/app_user.dart';
import '../services/console_utility.dart';
import '../services/dialog_service.dart';

class FirestoreService {
  final DialogService dialogService = serviceLocator<DialogService>();

  final CollectionReference _usercollectionReference =
      Firestore.instance.collection('userProfiles');

  Future<bool> createUserProfile(
    // AuthResult authResult,
    // var userProfileData,
    AppUser appUser,
  ) async {
    try {
      await _usercollectionReference
          .document(appUser.id)
          .setData(appUser.toJson());
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
