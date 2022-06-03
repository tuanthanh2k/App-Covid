import 'package:flutter/material.dart';
import 'package:vncovi/models/countries_covid.dart';
import 'package:vncovi/repository/countries_covid_repo.dart';


class StateOfDropdown extends ChangeNotifier {
  List<CountriesCovid>? _countriesCovid = [];
  List<CountriesCovid>? get countriesCovid => _countriesCovid;

  List<String>? _items = [];
  List<String>? get items => _items;


  bool _loading = false;
  bool get loading => _loading;

  bool _error = false;
  bool get error => _error;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CountriesCovidRepo _service = CountriesCovidRepo();

  void setError(bool value, String? message) {
    _error = value;
    _errorMessage = message;
    notifyListeners();
  }

  void setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void setData(List<String>? val) {
    _items = val;
    notifyListeners();
  }


  String _selectedItem = '';

  String get selected => _selectedItem;

  void setselected(String item) {
    _selectedItem = item;
    notifyListeners();
  }
  int _caseCovid = 0;
  int _recoverCovid = 0;
  int _activeCovid = 0;
  int _dealtCovid = 0;

  int get caseCovid => _caseCovid;

  int get recoverCovid => _recoverCovid;

  int get activeCovid => _activeCovid;

  int get dealtCovid => _dealtCovid;

  void setDataCovid(int caseC, int recoverC, int activeC, int dealtC) {
    _caseCovid = caseC;
    _recoverCovid = recoverC;
    _activeCovid = activeC;
    _dealtCovid = dealtC;
    notifyListeners();
  }

  Future<void> getItemCountry() async {
    List<String> newList = await _service.getCountry();
    setData(newList);
    setselected(newList.first);
    CountriesCovid covidCounties = await _service.getCovidCountry(selected);
    setDataCovid(covidCounties.cases!.toInt(), covidCounties.recovered!.toInt(),
        covidCounties.active!.toInt(), covidCounties.deaths!.toInt());
  }


  Future<void> getCovidCountry1() async {
    CountriesCovid covidCounties = await _service.getCovidCountry(selected);
    setDataCovid(covidCounties.cases!.toInt(), covidCounties.recovered!.toInt(),
        covidCounties.active!.toInt(), covidCounties.deaths!.toInt());
  }
}