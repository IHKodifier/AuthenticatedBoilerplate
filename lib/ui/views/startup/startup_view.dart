import '../welcome/welcome_view.dart';
// import 'package:AuthenticatedBiolerPlate/ui/views/welcome/welcome_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/busy_overlayBuilder.dart';
import '../../shared/loding_spinner.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/home/home_view.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/home/home_viewmodel.dart';
import '../login/login_view.dart';
import '../startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.resolveStartupLogin(),
      builder: (context, model, child) => 
      BusyOverlayBuilder(
        title: 'Loading',
        busyValue: model.isBusy,
        childWhenIdle: WelcomeView(),
      ),
    );
  }
}
