import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vncovi/modules/authentication/login_page.dart';
import 'package:vncovi/route/route_name.dart';
import 'controller/nav_controller.dart';
import 'modules/declaration/declaration_page.dart';
import 'modules/home/home_page.dart';
import 'modules/information/information_covid_page.dart';
import 'modules/qr/qr_page.dart';
import 'modules/vaccination/vaccination_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user();
  }

  user() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    print('Kiem tra user: $user');

    if (user != null) {
      page = const HomePage();
    } else {
      page = const LoginPhonePage();
      // page = LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
            child: page!, //
          ),
          if (navigation.screenName == RouteName.infoPage)
            MaterialPage(child: InformationCovidPage()),
          if (navigation.screenName == RouteName.qrPage)
             const MaterialPage(child: QRPage()),
          if (navigation.screenName == RouteName.healthDeclarationPage)
             MaterialPage(child: DeclarationPage()),
          if (navigation.screenName == RouteName.vaccinationPage)
             MaterialPage(
              child: VaccinationPage(),
            ),
        ],
        onPopPage: (route, result) {
          bool popStatus = route.didPop(result);
          if (popStatus == true) {
            Provider.of<NavigationController>(context, listen: false)
                .changScreen(RouteName.homePage);
          }
          return popStatus;
        },
      ),
    );
  }
}
