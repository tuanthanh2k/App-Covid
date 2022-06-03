import 'package:flutter/material.dart';
import 'package:vncovi/modules/home/home_page.dart';
import 'package:vncovi/modules/home_test/home.dart';

class RouterControl {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'TestPage':
        return MaterialPageRoute(builder: (context) => const HomeTestPage());
      case 'HomePage':
        return MaterialPageRoute(builder: (context) => const HomePage());
      case 'InfoPage':
      //return MaterialPageRoute(builder: (context)=> const ());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
