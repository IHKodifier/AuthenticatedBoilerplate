

// import 'package:AuthenticatedBiolerPlate/ui/views/signup/signup_viewmodel.dart';
import '../../../shared/busy_overlayBuilder.dart';
import 'package:flutter/material.dart';
import '../signup_viewmodel.dart';

class SignupForm extends StatefulWidget {
  SignupViewModel model;
  SignupForm({
    this.model
  }

  );
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return BusyOverlayBuilder(
      busyValue: widget.model.isBusy,
      title: 'Loading',
      childWhenIdle: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 100,
                  // child: _buildStack(context),
                ),
                Container(
                   
 ),],),),),),);
 }
}