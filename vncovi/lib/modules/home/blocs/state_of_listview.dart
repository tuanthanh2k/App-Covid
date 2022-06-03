import 'package:flutter/material.dart';
import 'package:vncovi/models/countries_covid.dart';
import 'package:vncovi/repository/countries_covid_repo.dart';


class StateOfListView extends ChangeNotifier {
  List<CountriesCovid>? _countriesCovid = [];
  List<CountriesCovid>? get countriesCovid => _countriesCovid;

  List<String>? _items = [];
  List<String>? get item => _items;


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

  void setDataCovid(List<CountriesCovid>? val) {
  _countriesCovid = val;
    notifyListeners();
  }

  Future<void> getAllPost() async {
    setLoading(true);
    List<String> newList = await _service.getCountry(
      onError: (message) {
        setError(true, message);
        setLoading(false);
      },
    );
    setData(newList);
    setLoading(false);
  }

  Future<void> getCovidCountry() async {
    setLoading(true);
    List<CountriesCovid>? newList = await _service.getCountriesCovid(
      onError: (message) {
        setError(true, message);
        setLoading(false);
      },);
    setDataCovid(newList);
    setLoading(false);
  }
}