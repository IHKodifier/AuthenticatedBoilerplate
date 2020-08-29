import 'package:flutter/material.dart';
import 'package:AuthenticatedBoilerplate/ui/views/welcome/components/body.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Body(),
      ),
    );
  }
}