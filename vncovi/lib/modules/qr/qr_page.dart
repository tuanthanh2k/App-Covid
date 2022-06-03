import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vncovi/components/bottomnav.dart';
import 'package:vncovi/components/my_drawer.dart';
import 'package:vncovi/themes/app_assets.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              child: SvgPicture.asset(AppAssets.menu),
              onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: MyDrawer(),
      body: SizedBox(),
      bottomNavigationBar: const BottomNav(
        activeButtonIndex: 2,
      ),
    );
  }
}
