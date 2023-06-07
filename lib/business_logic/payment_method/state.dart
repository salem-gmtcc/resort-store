import 'package:resort_store/data/model/payment_methods/payment_methods.dart';

abstract class PaymentMethodStates {}

class InitPaymentMethodState extends PaymentMethodStates {}

class ErrorPaymentMethodState extends PaymentMethodStates {
  String? error;

  ErrorPaymentMethodState(this.error);
}

class SuccessPaymentMethodState extends PaymentMethodStates {
  final PaymentMethodModel paymentMethodModel;

  SuccessPaymentMethodState({required this.paymentMethodModel});
}

class SuccessSendPaymentMethodState extends PaymentMethodStates {
  final SendPaymentMethodModel sendPaymentMethodModel;

  SuccessSendPaymentMethodState({required this.sendPaymentMethodModel});
}

class SuccessFinalPayMethodState extends PaymentMethodStates {
  SuccessFinalPayMethodState();
}

class LoadingPaymentMethodState extends PaymentMethodStates {}
