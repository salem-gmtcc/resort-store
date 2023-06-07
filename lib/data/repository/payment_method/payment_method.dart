import 'package:resort_store/data/model/payment_methods/payment_methods.dart';
import 'package:resort_store/data/services/payment_method/payment_method.dart';

class PaymentMethodRepository {
  final PaymentMethodsService paymentMethodsService;

  PaymentMethodRepository(this.paymentMethodsService);

  //TODO: Get Payment Method Repo
  Future<dynamic> getPaymentMethodRepository() async {
    final data = await paymentMethodsService.getPaymentMethodsService();
    if (data != null) {
      return Future.value(PaymentMethodModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }

  //TODO: Send Payment Method Repo
  Future<dynamic> sendPaymentMethodRepository(Map<String, dynamic> body) async {
    final data = await paymentMethodsService.sendPaymentMethodsService(body);
    if (data != null) {
      return Future.value(SendPaymentMethodModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }


  //TODO: final pay Method Repo
  Future<dynamic> finalPayMethodRepository() async {
    final data = await paymentMethodsService.finalPayMethodService();
    if (data != null) {
      return Future.value(data);
    } else {
      return Future(() => null);
    }
  }
}
