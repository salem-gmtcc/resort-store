import 'package:resort_store/business_logic/country/state.dart';
import 'package:resort_store/data/repository/country/country.dart';
import 'package:bloc/bloc.dart';

class CountryCubit extends Cubit<CountryStates> {
  final CountryRepository countryRepository;

  CountryCubit({required this.countryRepository}) : super(InitCountryState());

  getCountryCubit() {
    emit(LoadingCountryState());
    countryRepository.getCountryRepository().then((value) {
      emit(SuccessCountryState(countryModel: value));
    }).catchError((error) {
      emit(ErrorCountryState(error.toString()));
    });
  }

  getZoneCubit(String countryId) {
    emit(LoadingCountryState());
    countryRepository.getZoneRepository(countryId).then((value) {
      print("value : $value");
      emit(SuccessZoneState(zoneModel: value));
    }).catchError((error) {
      emit(ErrorCountryState(error.toString()));
    });
  }
}
