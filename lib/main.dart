import 'package:bnv/firebase/auth.dart';
import 'package:bnv/pages/root_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(BedavaNeVarApp());

class BedavaNeVarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RootPage(auth: new Auth()),
    );
  }
}
