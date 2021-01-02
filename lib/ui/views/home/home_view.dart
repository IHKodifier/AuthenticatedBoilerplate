import 'package:flutter/material.dart';


class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
          child: Container(color: Colors.greenAccent,
      child: Center(
        child: Text('user Home'),
      ),
        
      ),
    );
  }
}