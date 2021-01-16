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
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthenticationService {
  // all services
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final DialogService _dialogService = serviceLocator<DialogService>();
  final FirestoreService _firestoreService = serviceLocator<FirestoreService>();
  final NavigationService _navigationService =
      serviceLocator<NavigationService>();
  bool isBusy = false;
FirebaseAuth get authInstance=>_authInstance;
// this represents the App wide- Global currently authenticated user
// if no user is logged in  this wil always be null
  AppUser currentAppUser = null;

  //  sets flag to display provider bage on View Profile
  bool isNewAppUser = false;
  String defaultRole;

  //  FB Sign In
  Map userProfile;
  bool _isLoggedIn = false;

//Phone Sign In
  String phoneNumber;
  String verificationId;
  String otp;
  bool codeHasBeenSent = false;
  String smsStatus =
      'We will send you \n a 6 digit code on\n  this mobile to verify you have access to this number';

  // for google sign
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleSignInAccount;
  GoogleSignInAuthentication googleSignInAuthentication;
  AuthCredential authCredential;
//  AuthResult authResult;
  final fbLogin = FacebookLogin(debug: false);

//attempts to sign in the user, returns [True] if success or otherwise [False]
  Future<bool> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    var authResult;
    try {
      authResult = await _authInstance.signInWithEmailAndPassword(
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
      authResult = await _authInstance.createUserWithEmailAndPassword(
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
      await _authInstance.signOut();
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
    // setBusy(true);
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
        'Google successfully authenticated your account');
    ConsoleUtility.printToConsole(
        'attempting to login ${googleSignInAccount.email} with Firebase');
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCredential);

    if (userCredential.user != null) {
      // sign in with firebase successfull
      ConsoleUtility.printToConsole(
          '${googleSignInAccount.email} successfully authenticated with Firebase ');
      ConsoleUtility.printToConsole(
          'FirebaseAuth User  UID equals  ${userCredential.user.uid.toString()}');
      isNewAppUser = userCredential.additionalUserInfo.isNewUser;
      currentAppUser = AppUser.fromFireUser(
          userCredential.user, userCredential.additionalUserInfo.providerId);

      if (userCredential.additionalUserInfo.isNewUser) {
        //  save [AppUser] to firestore
        ConsoleUtility.printToConsole(
            'creating AppUser for the user in Firestore');

        await FirestoreService().createAppUser(currentAppUser);
        // Navigate to Edit Profile View
        _navigationService.navigateTo(routes.ViewProfileViewRoute);
      } else {
        ConsoleUtility.printToConsole(
            'System detected that you are  \n NOT \n a new user.....\n you will be directed to Home View');
        // Navigate to Home View
        // _navigationService.navigateTo(routes.HomeViewRoute);
        // TODO: read  returning user from appUsers and set to current AppUser
        //
      }
    } else {}
  }

  Future signInWithFacebook() async {
    ConsoleUtility.printToConsole('Attempting Facebook Sign in ');
    final result = await fbLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      // FacebookPermission.userPhotos
    ]);
    switch (result.status) {
      case FacebookLoginStatus.success:
        ConsoleUtility.printToConsole('Facebook Login Success');
        // TODO uncomment the code below and implement app speific logic
        final FacebookAccessToken facebookAccessToken = result.accessToken;
        // convert to Auth Credential
        final AuthCredential fbAuthCredential =
            FacebookAuthProvider.credential(facebookAccessToken.token);
        // attempt login with Firebase
        ConsoleUtility.printToConsole(
            'attempting to login facebook user with Firebase');
        final authResult =
            await _authInstance.signInWithCredential(fbAuthCredential);
        ConsoleUtility.printToConsole(
            '${authResult.user.displayName} has been logged into Firebase with facebook using email ${authResult.user.email}');
        ConsoleUtility.printToConsole(
            'checking newuser=${authResult.additionalUserInfo.isNewUser.toString()}');
        // authResult.additionalUserInfo.isNewUser;

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        break;

      default:
    }
  }

  Future signInWithTwitter() {
    ConsoleUtility.printToConsole('Attempting Twitter Sign in ');
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    ConsoleUtility.printToConsole(
        'Authentication Service Attempting Phone Number Sign in with \t ${this.phoneNumber} ');
    isBusy = true;
    // await _authInstance.verifyPhoneNumber(
    //     phoneNumber: this.phoneNumber,
    //     timeout: Duration(seconds: 20),
    //     verificationCompleted: verificationCompleted,
    //     verificationFailed: verificationFailed,
    //     codeSent: handleCodeSent,-r
    //     codeAutoRetrievalTimeout: autoTimeOut);
    smsStatus = 'We will soon send the SMS code.....';
    isBusy = false;
  }

  final PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException exception) {
    // TODO implement this.
    ConsoleUtility.printToConsole(exception.message);
  };

  PhoneVerificationCompleted verificationCompleted(
      PhoneAuthCredential phoneAuthCredential) {
    ConsoleUtility.printToConsole(
        // TODO
        'looks like phone verifiction met success\n this is the auth credential\n${phoneAuthCredential.toString()}');
    _authInstance.signInWithCredential(phoneAuthCredential).then((value) {
      if (value.user != null) {
        ConsoleUtility.printToConsole('fireuser  Auto created');
        isBusy = false;
      }
    });

    // phoneAuthCredential.
  }

  handleCodeSent(String verId, [int forceCodeResend]) {
    ConsoleUtility.printToConsole('you otp has been sent ');
    smsStatus =
        ' Your sms Code has been sent!!!! \nWe are attempting to auto validate...';
    isBusy = true;
    this.verificationId = verId;
  }

  PhoneCodeAutoRetrievalTimeout autoTimeOut(String verId) {
    ConsoleUtility.printToConsole('Auto validation of OTP has did not succeed');
    smsStatus =
        'Auto validation of OTP has did not succeed. Please enter OTP  below and press "submit"';
    // this.codeHasBeenSent = true;
    isBusy = false;

    // verificationId = verId;
    this.verificationId = verId;
  }

  signInWithPhoneCredential(String otp) {
    final credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otp);
    _authInstance.signInWithCredential(credential).then((value) {
      ConsoleUtility.printToConsole('otp verfied. \n you will be logged in ');
      ConsoleUtility.printToConsole(
          'instance  wide current user is  ${(_authInstance.currentUser != null).toString()} ');
    }).catchError(onPhoneSignInError);
  }

  onPhoneSignInError() {
    ConsoleUtility.printToConsole('some phone sign in error occured');
  }
    Future<UserCredential> signInWithCredential(UserCredential credential)async  {
      var future = await   _authInstance.signInWithCredential(credential as AuthCredential);
            return future;

    }
}
