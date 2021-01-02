// import '../../shared/busy_overlayBuilder.dart';
import 'p../../../login/components/body.dart';
import '../login/login_viewmodel.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import '../../shared/busy_overlayBuilder.dart';

class LoginView extends StatelessWidget {
  //text controllers and fields
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  BuildContext _localContext;

  @override
  Widget build(BuildContext context) {
    this._localContext = context;
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: ()=> LoginViewModel(),
      builder: (context,model, child)=> BusyOverlayBuilder(
        busyValue: model.isBusy,
        title: 'Loading',
              childWhenIdle: SafeArea(
          child: Scaffold
          (appBar: AppBar(title: Text('Sign in '),
          ),
          body: Body(model:model),
          )),
      ), 
      );
  }
}
