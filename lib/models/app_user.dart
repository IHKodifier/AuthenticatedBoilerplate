// import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/';

/// default [photoURL] if none provided
String _photoURLifBlank =
    'https://st4.depositphotos.com/15973376/24173/v/950/depositphotos_241732228-stock-illustration-user-account-circular-line-icon.jpg';

class AppUser {
  String uid;
  String email;
  String displayName;
  // final String lastName;
  // final String userRoles;
  String photoURL;
  String providerId;

  AppUser(
      {this.uid,
      this.displayName,
      // this.lastName,
      this.email,
      // this.profileTitle,
      // this.userRoles,
      this.photoURL});

  AppUser.fromUserCredential(
      {UserCredential userCredential, String providerId}) {
    uid = userCredential.user.uid;
    email = userCredential.user.email;
    displayName = userCredential.user.displayName;
    photoURL = userCredential.user.photoURL;
    providerId = providerId;

// for phone users
// email,displayName and photoURL are null at signup
    if (providerId == 'Phone') {
      email = '${userCredential.user.phoneNumber}.phoneUser@this.app';
      displayName = 'PhoneUser [${userCredential.user.phoneNumber} ]';
      photoURL = _photoURLifBlank;
//for Email users
//  displayName and photoURL are null  at signup
    } else if (providerId == 'Email') {
      email = userCredential.user.email;
      displayName = userCredential.user.email;
      photoURL = _photoURLifBlank;
    }
    this.providerId = providerId;
  }

  AppUser.fromData(Map<String, dynamic> data, String providerId)
      : uid = data['id'],
        displayName = data['displayName'],
        // lastName = data['lastName'],
        email = data['email'],
        providerId = providerId,
        // profileTitle = data['profileTitle'],
        // userRoles = data['profileType'],
        photoURL = data['photoUrl'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'displayName': displayName,
      // 'lastName': lastName,
      'email': email,
      // 'profileTitle': profileTitle,
      // 'userRoles': userRoles,
      'providerId': providerId,
      'photoUrl': photoURL,
    };
  }

  String toPrint() {
    String str;
    str =
        ' ${this.displayName}\n ${this.email}\n ${this.photoURL}\n${this.providerId}\n${this.uid}';
    return str;
  }
}
