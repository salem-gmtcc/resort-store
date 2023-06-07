import 'package:resort_store/data/model/payment_address/payment_address.dart';

abstract class PaymentAddressStates {}

class InitPaymentAddressState extends PaymentAddressStates {}

//TODO: Get All Payment Address
class SuccessGetAllPaymentAddressState extends PaymentAddressStates {
  final PaymentAddressModel? paymentAddressModel;

  SuccessGetAllPaymentAddressState({required this.paymentAddressModel});
}

//TODO: save New Payment Address
class SuccessSaveNewPaymentAddressState extends PaymentAddressStates {
  final SavePaymentAddressModel savePaymentAddressModel;

  SuccessSaveNewPaymentAddressState({required this.savePaymentAddressModel});
}

//TODO: send Existing Payment Address
class SuccessSendExistingPaymentAddressState extends PaymentAddressStates {
  final SavePaymentAddressModel savePaymentAddressModel;

  SuccessSendExistingPaymentAddressState(
      {required this.savePaymentAddressModel});
}

class ErrorPaymentAddressState extends PaymentAddressStates {
  String? error;
  ErrorPaymentAddressState(this.error);
}

class LoadingPaymentAddressState extends PaymentAddressStates {}
