// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_covid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountriesCovid _$CountriesCovidFromJson(Map<String, dynamic> json) =>
    CountriesCovid(
      updated: json['updated'] as int?,
      country: json['country'] as String?,
      countryInfo: json['countryInfo'] == null
          ? null
          : CountryInfo.fromJson(json['countryInfo'] as Map<String, dynamic>),
      cases: json['cases'] as int?,
      todayCases: json['todayCases'] as int?,
      deaths: json['deaths'] as int?,
      todayDeaths: json['todayDeaths'] as int?,
      recovered: json['recovered'] as int?,
      todayRecovered: json['todayRecovered'] as int?,
      active: json['active'] as int?,
      critical: json['critical'] as int?,
    );

Map<String, dynamic> _$CountriesCovidToJson(CountriesCovid instance) =>
    <String, dynamic>{
      'updated': instance.updated,
      'country': instance.country,
      'countryInfo': instance.countryInfo,
      'cases': instance.cases,
      'todayCases': instance.todayCases,
      'deaths': instance.deaths,
      'todayDeaths': instance.todayDeaths,
      'recovered': instance.recovered,
      'todayRecovered': instance.todayRecovered,
      'active': instance.active,
      'critical': instance.critical,
    };
