import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vncovi/components/bottomnav.dart';
import 'package:vncovi/components/header/header.dart';
import 'package:vncovi/components/my_drawer.dart';
import 'package:vncovi/modules/authentication/login_page.dart';
import 'package:vncovi/modules/home/component/dropdown_btn.dart';
import 'package:vncovi/providers/log_provider.dart';
import 'package:vncovi/repository/account_repo.dart';
import 'package:vncovi/themes/app_assets.dart';
import 'package:vncovi/themes/app_colors.dart';
import 'package:vncovi/themes/app_styles.dart';

import 'component/covid_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    postAccount();
  }

  postAccount() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    final myPhone = user?.phoneNumber;
    final myUid = user?.uid;
    const LogProvider('📱').log(myPhone!);
    const LogProvider('🔒').log(myUid!);
    // print('Phone of user: $myPhone ${myPhone.runtimeType}');
    // print('uid of user: $myUid ${myUid.runtimeType}');
    await AccountRepo()
        .postAccountData(myUid, myPhone)
        .then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              textTop: 'Đeo khẩu trang',
              textBottom: 'trước khi ra khỏi nhà',
              image: AppAssets.Drcorona,
              onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
            ),
            const DropdownBtn(),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text(
                        "Bản đồ dịch bệnh",
                        style: AppStyle.kTitleTextStyle,
                      ),
                      Text(
                        "Xem chi tiết",
                        style: TextStyle(
                          color: AppColor.kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const CovidMap(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(
        activeButtonIndex: 0,
      ),
    );
  }
}
