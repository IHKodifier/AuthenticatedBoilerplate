/// # region Legal

/// Copyright 2017 The EnigmaTek.Inc. All rights reserved.
/// Use of this source code is governed by a BSD-style license that can be
/// found in the LICENSE file.
/// endregion

/// # region imports
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

/// endregion

/// # region ClassInfo
/// final String className='AuthenticationService'
/// final String _version = '1.0.0';
/// final String _packageName = 'AuthenticatedBoilerPlate';
/// endregion

/// this class wraps all the functionality required by an App to authenticate its users.
/// Singleton instance of this class is available across the  App  and get can be refernced by
/// instantiating an [[AuthenticationService]] via call to serviceLocator. syntax below

/// final AuthenticationService _authService =serviceLocator<AuthenticationService>();

/// Uses signupWithEmail(...),signInWithGoogle(),signInWithFacebook(),  signInWithTwitter(),signInWithPhoneNumber(...),
/// loginWithEmail(...),

class AuthenticationService {
  /// all services
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final DialogService _dialogService = serviceLocator<DialogService>();
  final FirestoreService _firestoreService = serviceLocator<FirestoreService>();
  final NavigationService _navigationService =
      serviceLocator<NavigationService>();

  /// Data members

  FirebaseAuth get authInstance => _authInstance;

  /// The App-wide Global currently authenticated [AppUser]
  /// if no user is logged in  this wil always be null
  AppUser currentAppUser = null;

  ///  Holds the appropriate redirect route to navigate to
  String redirectRoute = '';

  /// default [photoURL] if none provided
  String _photoURLifBlank =
      'https://st4.depositphotos.com/15973376/24173/v/950/depositphotos_241732228-stock-illustration-user-account-circular-line-icon.jpg';

  ///

  ///  sets flag to display provider bage on View Profile
  bool isNewAppUser = false;

  ///  the defaultRole selected for [currentAppUser] at the time of login
  ///  if it has more than 1 roles assigned i.e.  [getAllRolesForUser.length] >1
  String defaultRole = 'DefaultRole';

  ///  FaceBook Sign In
  Map userProfile;
  bool _isLoggedIn = false;
  final fbLogin = FacebookLogin(debug: false);

  /// Phone Sign In
  String phoneNumber;
  String verificationId;
  String otp;
  final PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException exception) {
    /// TODO implement this.
    ConsoleUtility.printToConsole(exception.message);
  };

  /// Google sign In
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount googleSignInAccount;
  GoogleSignInAuthentication googleSignInAuthentication;
  AuthCredential authCredential;

  /// attempts to sign in the user with EMAIL/PASSWORD
  ///  returns [True] if success or otherwise [False]
  Future<dynamic> loginWithEmail({
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
      /// show error dialog to user
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: e.toString(),
      );
      ConsoleUtility.printToConsole(e.message);
      return null;
    }

    if (authResult.user != null) {
      ConsoleUtility.printToConsole(
          'sign in with EMAIL/PASSWORD successfull for $email');

      /// see if user has signed in first time after sign up, should receive profile completion invite
      // handleFirstSignIn();

      // TODO
      // get the user from [AppUsers] collection in firestore
      getAppUserDoc(email);
      //set the logged in user as current user across the app

      setRedirectRoutes();
      executeRedirects();

      return authResult.user;
    } else {
      currentAppUser = null;
      return null;
    }
  }

  /// returns a list of Strings for all user-Roles assigned to current user
  /// returns 'DefaultRole' if no speicic role is set.
  List<String> getAllRolesForUser() {
    // TODO
    // List<String> roles;
    // if (currentAppUser != null) {
    //      if (currentUserProfile['userRoles'].toString().contains(',')) {
    //        roles = currentUserProfile['userRoles'].toString().split(',');
    //      } else {
    //        roles = [currentUserProfile['userRoles'].toString()];
    //      }
    //      return roles;
    //    } else {
    //      throw Exception('defaultRole for user has not been set');
    // }
  }

  /// reads the Firestore document from [AppUsers] collection for the [authInstance.currentUser]
  /// and set it to [this.currentAppUser]
  ///
  Future<DocumentSnapshot> getAppUserDoc(String uid) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('/appUsers').doc(uid).get();
    if (documentSnapshot.data() != null) {
      ConsoleUtility.printToConsole(
          'AppUser Doc found for ${documentSnapshot.data().toString()}');
      currentAppUser = AppUser.fromData(documentSnapshot.data(), 'Email');
      ConsoleUtility.printToConsole(
          'Global currentAppUser  variable has been set to ${currentAppUser.toString()}');
      return documentSnapshot;
    } else {
      ConsoleUtility.printToConsole('AppUser Doc NOT Found');
      isNewAppUser = false;
      currentAppUser = null;
      return documentSnapshot;
    }
  }

  setAuthenticatedUser(String uid) async {
    // try {
    //      var returnvalue = await getUserProfile(uid);
    //      if (returnvalue.data != null) {
    //        currentUserProfile = returnvalue.data;
    //        ConsoleUtility.printToConsole(currentUserProfile.toString());
    //        var roles = getAllRolesForUser();
    //        defaultRole = roles[0];
    //        ConsoleUtility.printToConsole(
    //            'defaultRole  is now set to " $defaultRole"');
    //      } else {
    //        // throw Exception('default user not set');
    //      }
    // } catch (e) {
    //   _dialogService.showDialog(title: e.message);
    // }
  }

  /// checks if a user is already Signed In  on this device. this property is required  by startup Authentication logic
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
    // @required var userData,
  }) async {
    UserCredential userCredential;
    try {
      userCredential = await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      handleCredentialSuccess(
          userCredential: userCredential, providerId: "Email");
      // executeRedirects();

      // }
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
      currentAppUser = null;
      ConsoleUtility.printToConsole('CurrentAppUser has been reset to null');
    } catch (e) {
      ConsoleUtility.printToConsole(e.message);
    }
  }

  ///create all user profile data here to save to [appUsers] collection
  _buildUserProfileMap(UserCredential userCredential, var userProfileData) {
    // userProfileData['email'] = userCredential.user.email;
    // userProfileData['uid'] = userCredential.user.uid;
    // userProfileData['creeatedBy'] = 'debugAdmin';
    // userProfileData['version'] = 'ViewModelBuiler2.2';
    // userProfileData['photoUrl'] = 'http:///i.pravatar.cc/300';
  }

  Future signInWithGoogle() async {
    /// setBusy(true);
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
      /// sign in with firebase successfull
      ConsoleUtility.printToConsole(
          '${googleSignInAccount.email} successfully authenticated with Firebase ');
      ConsoleUtility.printToConsole(
          'FirebaseAuth User  UID equals  ${userCredential.user.uid.toString()}');
      isNewAppUser = userCredential.additionalUserInfo.isNewUser;
      currentAppUser = AppUser.fromUserCredential(
          userCredential: userCredential,
          providerId: userCredential.additionalUserInfo.providerId);
      // currentAppUser=AppUser.fromFireUser(user: )

      if (userCredential.additionalUserInfo.isNewUser) {
        ///  save [AppUser] to firestore
        ConsoleUtility.printToConsole(
            'creating AppUser for the user in Firestore');

        await FirestoreService().createAppUserDoc(
          appUser: currentAppUser,
        );

        /// Navigate to Edit Profile View
        _navigationService.navigateTo(routes.ViewProfileViewRoute);
      } else {
        ConsoleUtility.printToConsole(
            'System detected that you are  \n NOT \n a new user.....\n you will be directed to Home View');

        /// Navigate to Home View
        /// _navigationService.navigateTo(routes.HomeViewRoute);
        /// TODO: read  returning user from appUsers and set to current AppUser
        ///
      }
    } else {}
  }

  Future signInWithFacebook() async {
    ConsoleUtility.printToConsole('Attempting Facebook Sign in ');
    final result = await fbLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,

      /// FacebookPermission.userPhotos
    ]);
    switch (result.status) {
      case FacebookLoginStatus.success:
        ConsoleUtility.printToConsole('Facebook Login Success');

        /// TODO uncomment the code below and implement app speific logic
        final FacebookAccessToken facebookAccessToken = result.accessToken;

        /// convert to Auth Credential
        final AuthCredential fbAuthCredential =
            FacebookAuthProvider.credential(facebookAccessToken.token);

        /// attempt login with Firebase
        ConsoleUtility.printToConsole(
            'attempting to login facebook user with Firebase');
        final authResult =
            await _authInstance.signInWithCredential(fbAuthCredential);
        ConsoleUtility.printToConsole(
            '${authResult.user.displayName} has been logged into Firebase with facebook using email ${authResult.user.email}');
        ConsoleUtility.printToConsole(
            'checking newuser=${authResult.additionalUserInfo.isNewUser.toString()}');

        /// authResult.additionalUserInfo.isNewUser;

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

    /// await _authInstance.verifyPhoneNumber(
    ///     phoneNumber: this.phoneNumber,
    ///     timeout: Duration(seconds: 20),
    ///     verificationCompleted: verificationCompleted,
    ///     verificationFailed: verificationFailed,
    ///     codeSent: handleCodeSent,-r
    ///     codeAutoRetrievalTimeout: autoTimeOut);
  }

  PhoneVerificationCompleted verificationCompleted(
      PhoneAuthCredential phoneAuthCredential) {
    ConsoleUtility.printToConsole(

        /// TODO
        'looks like phone verifiction met success\n this is the auth credential\n${phoneAuthCredential.toString()}');
    _authInstance.signInWithCredential(phoneAuthCredential).then((value) {
      if (value.user != null) {}
    });

    /// phoneAuthCredential.
  }

  handleCodeSent(String verId, [int forceCodeResend]) {
    ConsoleUtility.printToConsole('you otp has been sent ');

    this.verificationId = verId;
  }

  PhoneCodeAutoRetrievalTimeout autoTimeOut(String verId) {
    ConsoleUtility.printToConsole('Auto validation of OTP has did not succeed');

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

  Future<UserCredential> signInWithCredential(UserCredential credential) async {
    var future =
        await _authInstance.signInWithCredential(credential as AuthCredential);
    return future;
  }

  Future<void> handleCredentialSuccess({
    UserCredential userCredential,
    String providerId,
  }) async {
    /// this function only gets called when [_authInstance.signInWithCredential] returns
    /// a [UserCredntial] when loggin in with email/google/fb/phone

    ConsoleUtility.printToConsole(
        ' Firebase User  created in Firebase Auth with user id = \n${userCredential.user.uid}\n...........looking for existing AppUserDoc in appUsers collection in firestore........');

    /// check if user has an AppUserDoc in Firestore [appUsers] collection in Firebase
    final docsnap = await getAppUserDoc(userCredential.user.email);
    if (docsnap.data() != null) {
      //user is not signing in for first time
      //no need to do anything..take him to his home
      setRedirectRoutes(routeName: routes.HomeViewRoute);
      ConsoleUtility.printToConsole('AppUserDoc Exists........setting currentAppUser');
      currentAppUser =
          AppUser.fromData(docsnap.data(), docsnap.data()['providerId']);
      executeRedirects();
    } else {
      handleFirstSignIn(userCredential, 'Email');
    }

    ///
  }

  Future<void> handleFirstSignIn(
      UserCredential userCredential, String providerId) {
    ///this function handles if the user account has freshly been created and its first ever login since signup
    ///the user needs to be redirected to Profile view and AppUserDoc needs to be created based on submitted profie data

// redirect to profile View
    setRedirectRoutes(routeName: routes.ViewProfileViewRoute);
    currentAppUser = AppUser.fromUserCredential(
        providerId: providerId, userCredential: userCredential);
    _firestoreService.createAppUserDoc(appUser: currentAppUser);
    isNewAppUser = true;
    executeRedirects();
  }

  void setRedirectRoutes({String routeName}) {
    redirectRoute = routeName;
    ConsoleUtility.printToConsole('redirection set to $redirectRoute');
  }

  void executeRedirects() {
    // if (currentAppUser != null) {
    ConsoleUtility.printToConsole('executing redirect to route $redirectRoute');
    _navigationService.popAndPush(redirectRoute);
    // }
  }

  void refreshUser() {}

  void setCurrentAppUser({UserCredential userCredential, String providerId}) {
    currentAppUser = AppUser.fromUserCredential(
        userCredential: userCredential, providerId: providerId);

    switch (providerId) {
      case 'Email':
        currentAppUser.photoURL = this._photoURLifBlank;
        currentAppUser.displayName = currentAppUser.email;

        break;
      // implement case fofr phone auth to populate photoURL and displayname
      // case
      default:
    }

    // FirestoreService.
  }
}
