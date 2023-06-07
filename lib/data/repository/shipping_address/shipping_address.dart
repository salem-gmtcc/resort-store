import 'package:resort_store/data/services/shipping_address/shipping_address.dart';

import '../../model/shipping_address/shipping_address.dart';

class ShippingAddressRepository {
  final ShippingAddressService shippingAddressService;

  ShippingAddressRepository({required this.shippingAddressService});

  //TODO: get Shipping Address
  Future<dynamic> getShippingAddressRepository(
      Map<String, dynamic> body) async {
    final data = await shippingAddressService.getShippingAddressService(body);
    if (data != null) {
      return Future.value(ShippingAddressModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }


  //TODO : get All Address
  Future<dynamic> getAddressRepository() async {
    final data = await shippingAddressService.getAddressService();
    if (data != null) {
      return Future.value(ShippingAddressModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }

}
