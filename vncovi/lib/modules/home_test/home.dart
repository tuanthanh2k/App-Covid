import 'package:flutter/material.dart';
import 'package:vncovi/modules/home_test/widgets/all_widget.dart';
import 'package:vncovi/modules/home_test/widgets/dropdown_btn.dart';
import 'package:vncovi/modules/home_test/widgets/monitor_covid.dart';

class HomeTestPage extends StatelessWidget {
  const HomeTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AllWidget(),
    );
  }
}
