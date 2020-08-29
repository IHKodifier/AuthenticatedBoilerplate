import 'package:flutter/material.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/rounded_button.dart';
import 'package:AuthenticatedBoilerplate/app/service_locator.dart';
import 'package:AuthenticatedBoilerplate/app/route_paths.dart' as routes;
import 'package:AuthenticatedBoilerplate/services/navigation_service.dart';

class NewAccountSuccess extends StatelessWidget {
  final NavigationService navigationService =
      serviceLocator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  _buildCongrats(context),
                  SizedBox(height: 20),
                  // _buildOkIcon(context),
                  // SizedBox(height: 12.0),
                  _buildProfileInvite(context),
                 
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect _buildOkIcon(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 80,
        width: 80,
        color: Theme.of(context).primaryColor.withOpacity(0.15),
        child: Center(
          child: Icon(
            Icons.done,
            color: Theme.of(context).primaryColor,
            size: 80,
          ),
        ),
      ),
    );
  }

  Widget _buildCongrats(BuildContext context) {
    return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
      // spacing: 555,
      children: [
        _buildOkIcon(context),
        Text(
          'Congratulations!',
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: 32.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric( horizontal:36.0, vertical: 16),
          child: Text(
            'ّYou have successfully created an account',
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 22.0, 
                color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }

  _buildProfileInvite(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:36,vertical: 12),
          child: Text(
              'Its a good time to build your  Business Profile.  a good Business Profile helps your business grow ', style: Theme.of(context).textTheme.subtitle2.copyWith(color:Theme.of(context).primaryColor,fontSize: 16)),
        ),
        SizedBox(height: 20),
        RoundedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          text: 'BUILD PROFILE',
          press: () {
            // navigationService.navigateTo(routes.)
          },
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text('You can also do it later.',style: Theme.of(context).textTheme.subtitle2.copyWith(color:Theme.of(context).primaryColor,fontSize: 18)),
        ),
        RoundedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          text: 'Proceed to Login',
          press: () {
            navigationService.navigateTo(routes.LoginRoute);
          },
        ),
      ],
    );
  }
}
