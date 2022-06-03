import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vncovi/components/bottomnav.dart';
import 'package:vncovi/components/my_drawer.dart';
import 'package:vncovi/modules/vaccination/widgets/vaccine.dart';
import 'package:vncovi/themes/app_assets.dart';

class VaccinationPage extends StatelessWidget {
  VaccinationPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Đăng ký tiêm Vaccine'),
        automaticallyImplyLeading: false,
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
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.indigoAccent),
        ),
        child: const Vaccine(),
      ),
      bottomNavigationBar: const BottomNav(
        activeButtonIndex: 4,
      ),
    );
  }
}
