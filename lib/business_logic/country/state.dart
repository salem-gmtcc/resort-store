import 'package:resort_store/data/model/country/country.dart';

abstract class CountryStates {}

class InitCountryState extends CountryStates {}

class SuccessCountryState extends CountryStates {
  final CountryModel countryModel;

  SuccessCountryState({required this.countryModel});
}

class SuccessZoneState extends CountryStates {
  final ZoneModel zoneModel;

  SuccessZoneState({required this.zoneModel});
}

class ErrorCountryState extends CountryStates {
  String? error;

  ErrorCountryState(this.error);
}

class LoadingCountryState extends CountryStates {}
