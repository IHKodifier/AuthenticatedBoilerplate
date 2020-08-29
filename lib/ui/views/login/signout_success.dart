import 'package:flutter/material.dart';
// import 'package:philanthroctor/packageLib.dart';
// import 'package:philanthroctor/widgets/philanthroctorLogo.dart';

class SignoutSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up ',
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 350,
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:24.0,left: 16.0),
                    child: Text(
                      'You have succesfully signed out  ',
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontSize: 22.0),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  // PhilanthroctorLogo(),
                  SizedBox(
                    height: 12.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Container(
                      height: 180,
                      width: 180,
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.done,
                          color: Theme.of(context).primaryColor,
                          size: 150,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RaisedButton(
                        child: Text('PROCEED TO LOGIN '),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/login');
                        }),
                  ),
                  SizedBox(height: 100,),
                ],
              ),
            ],
            
          ),
        ),
      ),
    );
  }
}
