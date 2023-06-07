import 'package:resort_store/business_logic/payment_method/state.dart';
import 'package:resort_store/data/repository/payment_method/payment_method.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodStates> {
  PaymentMethodsCubit({required this.paymentMethodRepository})
      : super(InitPaymentMethodState());
  final PaymentMethodRepository paymentMethodRepository;

  //TODO: get payment method cubit
  getPaymentMethodCubit() {

      emit(LoadingPaymentMethodState());
    paymentMethodRepository.getPaymentMethodRepository().then((value) {
      print("*********   *** $value");
      emit(SuccessPaymentMethodState(paymentMethodModel: value));
    }).catchError((error) {
      emit(ErrorPaymentMethodState(error.toString()));
    });
  }

  //TODO: send payment method cubit
  sendPaymentMethodCubit(Map<String,dynamic> body) {
    emit(LoadingPaymentMethodState());
    paymentMethodRepository.sendPaymentMethodRepository(body).then((value) {
      emit(SuccessSendPaymentMethodState(sendPaymentMethodModel: value));
    }).catchError((error) {
      print("************-------------------");
      emit(ErrorPaymentMethodState(error.toString()));
    });
  }


  //TODO : final Pay Method
  finalPayMethodCubit() {
    emit(LoadingPaymentMethodState());
    paymentMethodRepository.finalPayMethodRepository().then((value){
      emit(SuccessFinalPayMethodState());
    }).catchError((e){
      emit(ErrorPaymentMethodState(e.toString()));
    });


  }


}
