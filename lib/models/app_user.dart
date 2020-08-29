// import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/';

class UserProfile {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String profileTitle;
  final String userRoles;
  final String photoUrl;

  UserProfile(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.profileTitle,
      this.userRoles,
      this.photoUrl});

  UserProfile.fromData(Map<String, dynamic> data)
      : id = data['id'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        email=data['email'],
        profileTitle = data['profileTitle'],
        userRoles = data['profileType'],
        photoUrl = data['photoUrl'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email':email,
      'profileTitle': profileTitle,
      'userRoles': userRoles,
      'photoUrl': photoUrl,
    };
  }
}
