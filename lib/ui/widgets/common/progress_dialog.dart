import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String _dialogMessage = "Lütfen bekleyin...";
bool _isShowing = false;

double _progress = 0.0;
ProgressDialogType _progressDialogType = ProgressDialogType.Normal;

class ProgressDialog {
  _MyDialog _dialog;

  BuildContext context;

  ProgressDialog({Key key, this.context, ProgressDialogType progressDialogtype, String message}) {
    _dialogMessage = message ?? _dialogMessage;
    _progressDialogType = progressDialogtype ?? ProgressDialogType.Normal;
  }

  void hide() {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context).pop();
      debugPrint('ProgressDialog dismissed');
    }
  }

  bool isShowing() {
    return _isShowing;
  }

  void setMessage(String mess) {
    _dialogMessage = mess;
    debugPrint("ProgressDialog message changed: $mess");
  }

  void show() {
    if (!_isShowing) {
      _dialog = new _MyDialog();
      _isShowing = true;
      debugPrint('ProgressDialog shown');
      showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              insetAnimationCurve: Curves.easeInOut,
              insetAnimationDuration: Duration(milliseconds: 100),
              elevation: 10.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: _dialog);
        },
      );
    }
  }

  void update({double progress, String message}) {
    debugPrint("ProgressDialog message changed: ");
    if (_progressDialogType == ProgressDialogType.Download) {
      debugPrint("Old Progress: $_progress, New Progress: $progress");
      _progress = progress;
    }
    debugPrint("Old message: $_dialogMessage, New Message: $message");
    _dialogMessage = message;
    _dialog.update();
  }
}

enum ProgressDialogType { Normal, Download }

// ignore: must_be_immutable
class _MyDialog extends StatefulWidget {
  var _dialog = new _MyDialogState();

  @override
  // ignore: must_be_immutable
  State<StatefulWidget> createState() {
    return _dialog;
  }

  update() {
    _dialog.changeState();
  }
}

class _MyDialogState extends State<_MyDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100.0,
        child: Row(children: <Widget>[
          const SizedBox(width: 15.0),
          SizedBox(
            width: 60.0,
            child: Image(
              image: AssetImage("assets/images/double_ring_loading_io.gif"),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: _progressDialogType == ProgressDialogType.Normal
                ? Text(_dialogMessage,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w700))
                : Stack(
                    children: <Widget>[
                      Positioned(
                        child: Text(_dialogMessage,
                            style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.w700)),
                        top: 35.0,
                      ),
                      Positioned(
                        child: Text("$_progress/100",
                            style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w400)),
                        bottom: 15.0,
                        right: 15.0,
                      ),
                    ],
                  ),
          )
        ]));
  }

  changeState() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _isShowing = false;
    debugPrint('ProgressDialog dismissed by back button');
  }
}
