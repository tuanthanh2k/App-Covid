import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'country_info.dart';

part 'countries_covid.g.dart';

@JsonSerializable()
class CountriesCovid extends Equatable{
  final int? updated;
  final String? country;
  final CountryInfo? countryInfo;
  final int? cases;
  final int? todayCases;
  final int? deaths;
  final int? todayDeaths;
  final int? recovered;
  final int? todayRecovered;
  final int? active;
  final int? critical;

  CountriesCovid(
      {this.updated,
        this.country,
        this.countryInfo,
        this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.todayRecovered,
        this.active,
        this.critical});

  factory CountriesCovid.fromJson(Map<String, dynamic> json) =>
      _$CountriesCovidFromJson(json);

  @override
  List<Object?> get props => [updated,country, countryInfo, cases, todayCases, deaths, todayDeaths, recovered, todayRecovered ,active, critical];
}

