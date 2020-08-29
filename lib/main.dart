import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:AuthenticatedBoilerplate/app/app.dart';
import 'package:AuthenticatedBoilerplate/app/service_locator.dart';

Future<void> main() async {
  // TODO:      Register all the models and services before the app starts
 
 WidgetsFlutterBinding.ensureInitialized();
  registerAllServicesWithLocator();

   await  Firebase.initializeApp();

  runApp(App());
}
