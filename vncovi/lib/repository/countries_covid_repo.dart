import 'package:dio/dio.dart';
import 'package:vncovi/models/countries_covid.dart';

const url = 'https://api.ncovvn.xyz/wom/countries';
final urlCountry = (country) => "$url/${country}";

class CountriesCovidRepo {
  var dio = Dio();

  Future<List<String>> getCountry({Function(String message)? onError}) async {
    try {
      final res = await dio.get(url);
      if (res.statusCode == 200) {
        final data = res.data as List;
        final List<String> countryList =
            data.map((e) => e['country'].toString()).toList();
        return countryList;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CountriesCovid> getCovidCountry(String country) async {
    try {
      var res = await dio.get(urlCountry(country));
      if (res.statusCode == 200) {
        final dataCovidCountry = res.data;
        print(dataCovidCountry);
        return CountriesCovid.fromJson(dataCovidCountry);
      } else {
        throw Exception('Không lấy được dữ liệu');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CountriesCovid>?> getCountriesCovid(
      {Function(String message)? onError}) async {
    try {
      final res = await dio.get(url);
      if (res.statusCode == 200) {
        final List data = res.data;
        final List<CountriesCovid> countriesCovid =
            data.map((json) => CountriesCovid.fromJson(json)).toList();
        return countriesCovid;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
