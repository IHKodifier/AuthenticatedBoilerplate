import 'package:flutter/material.dart';
import 'package:AuthenticatedBoilerplate/ui/shared/loding_spinner.dart';

/// A modal overlay that will show over your child widget (fullscreen) when the [busyValue] is true
///
/// Wrap your scaffold in this widget and set show value to model.isBusy to show a loading modal when
/// your model state is Busy
class BusyOverlayBuilder extends StatelessWidget {
  final Widget childWhenBusy;
  final Widget childWhenIdle;
  final String title;
  final bool busyValue;

  const BusyOverlayBuilder({this.childWhenBusy, @required this.childWhenIdle, this.title, @required this.busyValue}) ;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Material(
        child: Stack(children: <Widget>[
      childWhenIdle,
      IgnorePointer(
        child: childWhenBusy!=null? childWhenBusy:
        DefaultChildWhenBusy(busyValue: busyValue, screenSize: screenSize, title: title),
      ),
    ]));
  }

 
}

class DefaultChildWhenBusy extends StatelessWidget {
  const DefaultChildWhenBusy({
    
    @required this.busyValue,
    @required this.screenSize,
    @required this.title,
  });

  final bool busyValue;
  final Size screenSize;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: busyValue ? 1 : 0.0,
        child: Container(
          color: Colors.transparent.withOpacity(.40),
          width: screenSize.width,
          height: screenSize.height,
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),

          // color: Color.fromARGB(100, 0, 0, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Theme.of(context).backgroundColor.withOpacity(1),
              height: screenSize.height * .2,
              width: screenSize.width * .4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LoadingSpinner(),
                  Text(title,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ],
              ),
            ),
          ),
        ));
  }
}
