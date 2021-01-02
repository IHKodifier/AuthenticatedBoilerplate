// import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/';

class AppUser {
  final String uid;
  final String email;
  final String displayName;
  // final String lastName;
  // final String userRoles;
  final String photoURL;
  String providerId;

  AppUser(
      {this.uid,
      this.displayName,
      // this.lastName,
      this.email,
      // this.profileTitle,
      // this.userRoles,
      this.photoURL});

  AppUser.fromFireUser(User user, String providerId)
      : uid = user.uid,
        displayName = user.displayName,
        photoURL = user.photoURL,
        email = user.email,
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
      'providerId':providerId,
      'photoUrl': photoURL,
    };
  }
}
