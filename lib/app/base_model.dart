import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get isBusy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
