import 'package:resort_store/data/services/payment_address/payment_address.dart';

import '../../model/payment_address/payment_address.dart';

class PaymentAddressRepository {
  final PaymentAddressService paymentAddressService;

  PaymentAddressRepository({required this.paymentAddressService});


  //TODO : GET ALL PAYMENT ADDRESS
  Future<dynamic> getAllPaymentAddress() async {
    final data = await paymentAddressService.getAllPaymentAddressService();
    if (data != null) {
       return Future.value(PaymentAddressModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }

  //TODO : Send existing Payment address
  Future<dynamic> sendExistingPaymentAddress(String addressId ) async {
    final data = await paymentAddressService.sendExistingPaymentAddressService(addressId);
    if (data != null) {
      return Future.value(SavePaymentAddressModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }

  //TODO : add new Payment address
  Future<dynamic> saveNewPaymentAddress(Map<String, dynamic> body ) async {
    print("********* enter repository !");
    final data = await paymentAddressService.saveNewPaymentAddressService(body);
    if (data != null) {
      return Future.value(SavePaymentAddressModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }


}
