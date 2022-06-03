import 'package:flutter/material.dart';
import 'package:vncovi/modules/home_test/widgets/button_directional.dart';
import 'package:vncovi/modules/home/component/counter_covid.dart';
import 'package:vncovi/modules/home_test/widgets/dropdown_btn.dart';
import 'package:vncovi/modules/home_test/widgets/list_covid.dart';
import 'package:vncovi/modules/home_test/widgets/monitor_covid.dart';

import '../../home/component/list_countries_covid_expansiontile.dart';

class AllWidget extends StatelessWidget {
  const AllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          ButtonDirectional(
            label: 'Monitor covid',
            widget: MonitorCovid(),
          ),
          ButtonDirectional(
            label: 'Counter covid',
            widget: CounterCovid(
              number: 3,
              color: Colors.amber,
              title: 'rr',
            ),
          ),
          ButtonDirectional(
            label: 'List countries covid',
            widget: ListCountriesCovid(),
          ),
          ButtonDirectional(
            label: 'List countries covid ExpansionTile',
            widget: ListCovidCountriesExpansionTile(),
          ),
          ButtonDirectional(
            label: 'Dropdownbuton',
            widget: DropdownBtn(),
          ),
         
        ],
      ),
    );
  }
}
