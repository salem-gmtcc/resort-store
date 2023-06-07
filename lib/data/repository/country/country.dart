import 'package:resort_store/data/services/country/country.dart';

import '../../model/country/country.dart';

class   CountryRepository {
  final CountryService countryService;
  CountryRepository({required this.countryService});

  //TODO : GET COUNTRY
  Future<dynamic> getCountryRepository()async {
    print("*********************************************************** enter repo 1");
    final data = await countryService.getCountryService();
    print("***********************************************************  Data  :$data");
    if(data != null){
      print("*********************************************************** enter repo 2");
      return Future.value(CountryModel.fromJson(data));
    }else {
      return Future(() => null);
    }

  }



  //TODO : GET ZONE
  Future<dynamic> getZoneRepository(String countryId)async {
    final data = await countryService.getZonesByIdService(countryId);

    if(data != null){
      return Future.value(ZoneModel.fromJson(data));
    }else {
      return Future(() => null);
    }

  }

}