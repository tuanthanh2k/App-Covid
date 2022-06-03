import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vncovi/modules/home/blocs/state_of_listview.dart';
import 'package:vncovi/modules/home/component/empty.dart';
import 'package:vncovi/modules/home/component/error.dart';
import 'package:vncovi/modules/home_test/widgets/monitor_covid.dart';

class ListCountriesCovid extends StatefulWidget {
  const ListCountriesCovid({Key? key}) : super(key: key);

  @override
  State<ListCountriesCovid> createState() => _ListCountriesCovidState();
}

class _ListCountriesCovidState extends State<ListCountriesCovid> {
  late StateOfListView _state;

  @override
  void initState() {
    _state = StateOfListView();
    super.initState();
    _state.getCovidCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider<StateOfListView>(
        create: (_) => _state,
        child: Consumer<StateOfListView>(
          builder: (context, model, child) {
            return model.loading
                ? const Center(
                    child: Text(
                      'Loading',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: model.getCovidCountry,
                    child: model.error
                        ? Error()
                        : model.countriesCovid!.isEmpty
                            ? Empty()
                            : ListView.builder(
                                itemCount: model.countriesCovid!.length,
                                itemBuilder: (context, index) {
                                  print(model.countriesCovid![index].cases!);
                                  return MonitorCovid(
                                    cases: model.countriesCovid![index].cases,
                                    active: model.countriesCovid![index].active,
                                    recovered:
                                        model.countriesCovid![index].recovered,
                                    deaths: model.countriesCovid![index].deaths,
                                  );
                                },
                              ),
                  );
          },
        ),
      ),
    );
  }
}
