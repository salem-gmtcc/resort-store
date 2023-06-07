
import 'package:geolocator/geolocator.dart';

import '../../presentation/widgets/custom_toast.dart';

class AppFunction {

  //TODO :handle Location Permission
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast(text: "Location services are disabled. Please enable the services", color: ToastColors.WARNING);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast(text: "Location services are disabled. Please enable the services", color: ToastColors.WARNING);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast(text: "Location permissions are permanently denied, we cannot request permissions.", color: ToastColors.WARNING);
      return false;
    }
    return true;
  }





}