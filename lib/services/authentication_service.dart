import 'package:AuthenticatedBoilerPlate/app/service_locator.dart';
import 'package:AuthenticatedBoilerPlate/services/console_utility.dart';
import 'package:AuthenticatedBoilerPlate/services/dialog_service.dart';
import 'package:AuthenticatedBoilerPlate/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:AuthenticatedBoilerplate/app/service_locator.dart';
// import 'package:AuthenticatedBoilerplate/services/console_utility.dart';
// import 'package:AuthenticatedBoilerplate/services/dialog_service.dart';
// import 'package:AuthenticatedBoilerplate/services/firestore_service.dart';
// import '../models/app_user.dart';
// import 'package:AuthenticatedBoilerplate/services/console_utility.dart';
import '../models/app_user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
  final DialogService _dialogService = serviceLocator<DialogService>();
  // final Stream<FirebaseUser> authenticationStateStream =
  //     FirebaseAuth.instance.onChanged;
  final FirestoreService _firestoreService = serviceLocator<FirestoreService>();
  dynamic currentUserProfile;
  String defaultRole;

//attempts to sign in the user, returns [True] if success or otherwise [False]
  Future<bool> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    var authResult;
    try {
      authResult = await _firebaseAuthInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }     catch (e) {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: e.toString(),
      );
      ConsoleUtility.printToConsole(e.message);
      return false;
    }

    if (authResult.user != null) {
      ConsoleUtility.printToConsole('sign in successfull');
      //get the user from [userProfiles] collection in firestore &
      //set the logged in user as current user across the app
      await setAuthenticatedUser(authResult.user.uid);
      return true;
    } else {
      return false;
    }
  }

  List<String> getAllRolesForUser() {
    List<String> roles;
    if (currentUserProfile != null) {
      if (currentUserProfile['userRoles'].toString().contains(',')) {
        roles = currentUserProfile['userRoles'].toString().split(',');
      } else {
        roles = [currentUserProfile['userRoles'].toString()];
      }
      return roles;
    } else {
      throw Exception('defaultRole for user has not been set');
    }
  }

  Future<DocumentSnapshot> getUserProfile(String uid) async {
    return Firestore.instance
        .collection('/userProfiles').document(uid).get();
        // .where('uid', isEqualTo: uid)
        // .getDocuments();
  }

  setAuthenticatedUser(String uid) async {
    try {
      var returnvalue = await getUserProfile(uid);
      if (returnvalue.data!=null) {
        currentUserProfile = returnvalue.data;
        ConsoleUtility.printToConsole(currentUserProfile.toString());
        var roles = getAllRolesForUser();
        defaultRole = roles[0];
        ConsoleUtility.printToConsole(
            'defaultRole  is now set to " $defaultRole"');
      } else {
        // throw Exception('default user not set');
      }
    } catch (e) {
      _dialogService.showDialog(title: e.message);
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user =  await FirebaseAuth.instance.currentUser;
    if (user != null) {
      await setAuthenticatedUser(user.uid);
      ConsoleUtility.printToConsole('ALREADY logged in user detected.\n returning ${user==null}');
      return true;
          }
    ConsoleUtility.printToConsole('NO already logged in user detected.\n returning ${user!=null}');
    return false;
  }

  Future<dynamic> signupWithEmail({
    @required String email,
    @required String password,
    @required var userData,
  }) async {
    var authResult;
    try {
      authResult = await _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        ConsoleUtility.printToConsole(
            ' Fireuser created \n\n user id = ${authResult.user.uid}');

        //create a [userProfile] for this user
        // await _firestoreService.createUserProfile(UserProfile(
        //     id: authResult.user.uid,
        //     firstName: userData['fullName'],
        //     email: email,
        //     userRoles: userData['roles'],
        //     photoUrl: 'https://i.pravatar.cc/300',
        //     profileTitle: userData['profileTitle']));
        // return authResult.user != null;
      }
    } catch (e) {
      _dialogService.showDialog(
        title: 'Signup Error',
        description: e.message.toString(),
      );
      ConsoleUtility.printToConsole(
          ' authentication service\n signupWithEmail\n ihk caught an exception \n${e.message}');
    }
  }

  Future signout() async {
    try {
      await _firebaseAuthInstance.signOut();
      ConsoleUtility.printToConsole('logged out of FireBase');
    } catch (e) {
      ConsoleUtility.printToConsole(e.message);
    }
  }

//create all user profile data here to save to [userProfiles] collection
  _buildUserProfileMap(UserCredential userCredential, var userProfileData) {
    userProfileData['email'] = userCredential.user.email;
    userProfileData['uid'] = userCredential.user.uid;
    userProfileData['creeatedBy'] = 'debugAdmin';
    userProfileData['version'] = 'ViewModelBuiler2.2';
    userProfileData['photoUrl'] = 'http://i.pravatar.cc/300';
  }

  Future<User> getCurrentUserProfile()  async{
    return _firebaseAuthInstance.currentUser;
  }
}
