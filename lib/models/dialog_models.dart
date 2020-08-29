import 'package:flutter/foundation.dart';

class AlertRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String cancelTitle;

  AlertRequest(
      {@required this.title,
      @required this.description,
      @required this.buttonTitle,
      this.cancelTitle});
}

class AlertResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;

  AlertResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}
