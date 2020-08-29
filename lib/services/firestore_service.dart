import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AuthenticatedBoilerplate/app/service_locator.dart';
import 'package:AuthenticatedBoilerplate/models/app_user.dart';
import 'package:AuthenticatedBoilerplate/services/console_utility.dart';
import 'package:AuthenticatedBoilerplate/services/dialog_service.dart';

class FirestoreService {
  final DialogService dialogService = serviceLocator<DialogService>();

  final CollectionReference _usercollectionReference =
      Firestore.instance.collection('userProfiles');

  Future<bool> createUserProfile(
    // AuthResult authResult,
    // var userProfileData,
    UserProfile userProfile,
  ) async {
    try {
      await _usercollectionReference
          .document(userProfile.id)
          .setData(userProfile.toJson());
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
