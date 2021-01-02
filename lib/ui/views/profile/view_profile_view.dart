import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../views/profile/view_profile_view_viewmodel.dart';

class ViewProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewProfileViewModel>.reactive(
      viewModelBuilder: () => ViewProfileViewModel(),
      onModelReady: (model) => model.getModelReady(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            model.isNewAppUser ? Text(' We got a NewAppUser') : null,
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                model.photoURL,
                height: 90,
              ),
            ),
            Text(model.currentAppUser.displayName),
            Text(model.currentAppUser.email),
            Center(child: Text('View-Profile View')),
            SizedBox(height: 30,),
            Container(
              width: double.infinity,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:32.0),
                child: RaisedButton(
                  child: Text('Continue',style: Theme.of(context).textTheme.button.copyWith(fontSize: 22),),
                  onPressed: model.navigateToUserHome,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: double.infinity,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:32.0),
                child: RaisedButton(
                  child: Text('Sign Out'),
                  onPressed: model.signout,
                  color: Theme.of(context).buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
