import 'package:flutter/material.dart';
import '../app/service_locator.dart';
import '../models/dialog_models.dart';
import '../services/dialog_service.dart';
import "package:rflutter_alert/rflutter_alert.dart";

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = serviceLocator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    Alert(
      context: context,
      title: request.title,
      desc: request.description,
      closeFunction: () =>
          _dialogService.dialogComplete(AlertResponse(confirmed: false)),
      buttons: [
        DialogButton(
          width: 150,
          child: Text(
            request.buttonTitle,
          ),
          onPressed: () {
            _dialogService.dialogComplete(AlertResponse(confirmed: true));
            Navigator.of(context).pop();
          },
        ),
      ],
    ).show();
  }
}
