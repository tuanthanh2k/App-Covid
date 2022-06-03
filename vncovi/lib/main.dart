import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vncovi/modules/firebase/firebase_initializer.dart';

import 'controller/nav_controller.dart';
import 'my_app.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(
    FirebaseInitializer(
      child: MultiProvider(
        providers:[
          ListenableProvider<NavigationController>(
            create: (_) => NavigationController(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}
