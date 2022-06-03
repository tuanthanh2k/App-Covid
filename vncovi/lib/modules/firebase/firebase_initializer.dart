
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vncovi/themes/app_assets.dart';

class FirebaseInitializer extends StatefulWidget {
  final Widget child;

  const FirebaseInitializer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  _FirebaseState createState() => _FirebaseState();
}

class _FirebaseState extends State<FirebaseInitializer> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {}

        if (snapshot.connectionState == ConnectionState.done) {
          print('firebase ok');
          return widget.child;
        }

        print('firebase loading');
        return Container(
         color: Colors.white,
        );
      },
    );
  }
}
