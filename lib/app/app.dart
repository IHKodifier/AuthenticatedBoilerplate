import 'package:flutter/material.dart';
import 'package:AuthenticatedBoilerplate/managers/dialog_manager.dart';
import 'package:AuthenticatedBoilerplate/services/dialog_service.dart';
import 'package:AuthenticatedBoilerplate/services/navigation_service.dart';
import 'package:AuthenticatedBoilerplate/app/route_paths.dart' as routes;
import 'package:AuthenticatedBoilerplate/services/router.dart' as router;
import 'package:AuthenticatedBoilerplate/app/constants.dart' as constants;

import 'package:AuthenticatedBoilerplate/app/service_locator.dart';

class App extends StatelessWidget {
  ThemeData _buildTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      primaryColor: constants.appPrimaryColor,
      primaryColorLight: constants.appPrimaryLightColor,
      buttonColor: Theme.of(context).primaryColor,
      accentColor: constants.appAccentColor,
      backgroundColor: constants.appScaffoldBackgroundColor,

    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authenticated Boiler Plate',
      theme: _buildTheme(context),
      //builder below is need to ensure dialoge service stays at the top of widget tree
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(
                  child: widget,
                )),
      ),
      //TODO FIX THIS
      onGenerateRoute: router.generateRoute,
      navigatorKey: serviceLocator<NavigationService>().navigationKey,
      initialRoute: routes.StartupRoute,
    );
  }
}
