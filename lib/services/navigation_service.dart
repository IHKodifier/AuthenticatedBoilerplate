import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatiorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigatiorKey;

  bool goBack() {
    return _navigatiorKey.currentState.pop() as bool;
  }

  bool popAndPush(String routeName, {dynamic arguments}) {
    _navigatiorKey.currentState.pop();
    _navigatiorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigatiorKey.currentState.pushNamed(routeName);
  }
}
