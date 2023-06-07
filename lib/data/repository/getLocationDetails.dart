import 'package:resort_store/data/services/getLocationDetails/getLocationDetails.dart';

class GetLocationDetailsRepo {
  final GetLocationDetailsService getLocationDetailsService;

  GetLocationDetailsRepo({required this.getLocationDetailsService});

  Future<dynamic> getLocationDetailsRepo(double lat, double lon) async {
    final data = await getLocationDetailsService.getLocationSV(lat, lon);
    print("data ----------------------------------------- $data");
    return data;
  }
}
