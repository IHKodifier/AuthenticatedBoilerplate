import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/busy_overlayBuilder.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/loding_spinner.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/home/home_view.dart';
// import 'package:AuthenticatedBoilerplate/ui/views/home/home_viewmodel.dart';
import 'package:AuthenticatedBoilerplate/ui/views/login/login_view.dart';
import 'package:AuthenticatedBoilerplate/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.resolveStartupLogin(),
      builder: (context, model, child) => BusyOverlayBuilder(
        title: 'Loading',
        busyValue: model.isBusy,
        childWhenIdle: SafeArea(
                  child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/chat.svg'),
                  LoadingSpinner(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
