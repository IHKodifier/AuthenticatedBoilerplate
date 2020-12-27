import 'package:AuthenticatedBoilerPlate/app/service_locator.dart';
import 'package:AuthenticatedBoilerPlate/services/console_utility.dart';
import 'package:AuthenticatedBoilerPlate/services/dialog_service.dart';
import 'package:AuthenticatedBoilerPlate/services/firestore_service.dart';
import '../app/route_paths.dart' as routes;
import '../services/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/app_user.dart';

class AuthenticationService {
  // all services
  final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
  final DialogService _dialogService = serviceLocator<DialogService>();
  // final Stream<FirebaseUser> authenticationStateStream =
  //     FirebaseAuth.instance.onChanged;
  final FirestoreService _firestoreService = serviceLocator<FirestoreService>();
  final NavigationService _navigationService =
      serviceLocator<NavigationService>();

// this represents the App wide- Global currently authenticated user
// if no user is logged in  this wil always be null
  AppUser currentAppUser = null;
  //  sets flag to display provider bage on View Profile
  bool isNewAppUser = false;
  String defaultRole;

  // for google sign
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleSignInAccount;
  GoogleSignInAuthentication googleSignInAuthentication;
  AuthCredential authCredential;
//  AuthResult authResult;

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
    } catch (e) {
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
      // await setAuthenticatedUser(authResult.user.uid);
      return true;
    } else {
      return false;
    }
  }

  List<String> getAllRolesForUser() {
    List<String> roles;
    if (currentAppUser != null) {
      //   if (currentUserProfile['userRoles'].toString().contains(',')) {
      //     roles = currentUserProfile['userRoles'].toString().split(',');
      //   } else {
      //     roles = [currentUserProfile['userRoles'].toString()];
      //   }
      //   return roles;
      // } else {
      //   throw Exception('defaultRole for user has not been set');
    }
  }

  Future<DocumentSnapshot> getAppUserDoc(String uid) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('/appUsers').doc(uid).get();
    if (documentSnapshot.data() != null) {
      ConsoleUtility.printToConsole(
          'AppUser Doc found for ${documentSnapshot.data().toString()}');
      currentAppUser = AppUser.fromData(documentSnapshot.data());
      ConsoleUtility.printToConsole(
          'Global currentAppUser  variable has been set to ${currentAppUser.toString()}');
    } else {
      ConsoleUtility.printToConsole('AppUser Doc NOT Found');
      isNewAppUser = false;
      currentAppUser = null;
    }
  }

  setAuthenticatedUser(String uid) async {
    try {
      //   var returnvalue = await getUserProfile(uid);
      //   if (returnvalue.data != null) {
      //     currentUserProfile = returnvalue.data;
      //     ConsoleUtility.printToConsole(currentUserProfile.toString());
      //     var roles = getAllRolesForUser();
      //     defaultRole = roles[0];
      //     ConsoleUtility.printToConsole(
      //         'defaultRole  is now set to " $defaultRole"');
      //   } else {
      //     // throw Exception('default user not set');
      //   }
    } catch (e) {
      _dialogService.showDialog(title: e.message);
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      await setAuthenticatedUser(user.uid);
      ConsoleUtility.printToConsole(
          'ALREADY logged in user detected.\n returning ${user == null}');
      return true;
    }
    ConsoleUtility.printToConsole(
        'NO already logged in user detected.\n returning ${user != null}');
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
      }
      //create a [userProfile] for this user
      // await _firestoreService.createUserProfile(UserProfile(
      //     id: authResult.user.uid,
      //     firstName: userData['fullName'],
      //     email: email,
      //     userRoles: userData['roles'],
      //     photoUrl: 'https://i.pravatar.cc/300',
      //     profileTitle: userData['profileTitle']));
      // return authResult.user != null;
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

//create all user profile data here to save to [appUsers] collection
  _buildUserProfileMap(UserCredential userCredential, var userProfileData) {
    userProfileData['email'] = userCredential.user.email;
    userProfileData['uid'] = userCredential.user.uid;
    userProfileData['creeatedBy'] = 'debugAdmin';
    userProfileData['version'] = 'ViewModelBuiler2.2';
    userProfileData['photoUrl'] = 'http://i.pravatar.cc/300';
  }

  Future signInWithGoogle() async {
    ConsoleUtility.printToConsole(
        'Attempting Google Sign in \n awaiting account selection...');

    googleSignInAccount = await GoogleSignIn().signIn();

    ConsoleUtility.printToConsole(
        'selected google Account = ${googleSignInAccount.email}');

    googleSignInAuthentication = await googleSignInAccount.authentication;

    ConsoleUtility.printToConsole(
        'Authenticating  ${googleSignInAccount.email} from Google....');

    this.authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    ConsoleUtility.printToConsole(
        'Google successfully authenticated your account ');

    ConsoleUtility.printToConsole(
        'attempting to login ${googleSignInAccount.email} with Firebase');
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

    if (userCredential.user != null) {
      ConsoleUtility.printToConsole(
          '${googleSignInAccount.email} successfully authenticated with Firebase ');
      ConsoleUtility.printToConsole(
          'FirebaseAuth User UID= ${userCredential.user.uid.toString()}');
      if (userCredential.additionalUserInfo.isNewUser) {
        ConsoleUtility.printToConsole(
            'System detected that you are a NEW USER.....\n you will be directed to Edit profile View');


        currentAppUser = AppUser.fromFireUser(userCredential.user);
        isNewAppUser = userCredential.additionalUserInfo.isNewUser;
        ConsoleUtility.printToConsole('creating AppUser in Firestore');
        await FirestoreService().createAppUser(currentAppUser);



        // TODO:Navigate to Edit Profile View
        _navigationService.navigateTo(routes.ViewProfileViewRoute);
        // TODO: save [AppUser] to firestore
      } else {
        ConsoleUtility.printToConsole(
            'System detected that you are  \n NOT \n a new user.....\n you will be directed to Home View');
        // TODO:Navigate to Home View
        _navigationService.navigateTo(routes.ViewProfileViewRoute);
      }
    } else {}
  }

  Future signInWithTwitter() {
    ConsoleUtility.printToConsole('Attempting Twitter Sign in ');
  }

  Future signInWithFacebook() {
    ConsoleUtility.printToConsole('Attempting Facebook Sign in ');
  }

  Future signInWithPhoneNumber() {
    ConsoleUtility.printToConsole('Attempting PhoneNumber Sign in ');
  }
}
