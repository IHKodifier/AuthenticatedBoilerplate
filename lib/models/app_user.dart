// import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/';

/// default [photoURL] if none provided
String _photoURLifBlank =
    'https://st4.depositphotos.com/15973376/24173/v/950/depositphotos_241732228-stock-illustration-user-account-circular-line-icon.jpg';

class AppUser {
  final String uid;
  final String email;
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

  AppUser.fromFireUser({UserCredential userCredential, String providerId})
      : uid = userCredential.user.uid,
        displayName = userCredential.user.displayName,
        photoURL = userCredential.user.photoURL == null
            ? _photoURLifBlank
            : userCredential.user.photoURL,
        email = userCredential.user.email,
        providerId = providerId;

  AppUser.fromData(Map<String, dynamic> data)
      : uid = data['id'],
        displayName = data['firstName'],
        // lastName = data['lastName'],
        email = data['email'],
        // profileTitle = data['profileTitle'],
        // userRoles = data['profileType'],
        photoURL = data['photoUrl'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': displayName,
      // 'lastName': lastName,
      'email': email,
      // 'profileTitle': profileTitle,
      // 'userRoles': userRoles,
      'providerId': providerId,
      'photoUrl': photoURL,
    };
  }
}
