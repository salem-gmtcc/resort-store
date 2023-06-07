import 'package:resort_store/business_logic/payment_address/state.dart';
import 'package:resort_store/data/repository/payment_address/payment_address.dart';
import 'package:bloc/bloc.dart';

class PaymentAddressCubit extends Cubit<PaymentAddressStates> {
  PaymentAddressCubit({required this.paymentAddressRepository})
      : super(InitPaymentAddressState());
  final PaymentAddressRepository paymentAddressRepository;

  //TODO: get All Payment Address
  getAllPaymentAddressCubit() {
    emit(LoadingPaymentAddressState());
    paymentAddressRepository.getAllPaymentAddress().then((value) {
      emit(SuccessGetAllPaymentAddressState(paymentAddressModel: value));
    }).catchError((e) {
      emit(ErrorPaymentAddressState(e.toString()));
    });
  }

  //TODO: send Existing Payment Address
  sendPaymentAddressCubit(String addressId) {
    emit(LoadingPaymentAddressState());
    paymentAddressRepository
        .sendExistingPaymentAddress(addressId)
        .then((value) {
      emit(SuccessSendExistingPaymentAddressState(
          savePaymentAddressModel: value));
    }).catchError((e) {
      emit(ErrorPaymentAddressState(e.toString()));
    });
  }

  //TODO: save new Payment Address
  savePaymentAddressCubit(Map<String, dynamic> body) {
    emit(LoadingPaymentAddressState());
    paymentAddressRepository.saveNewPaymentAddress(body).then((value) {
      emit(SuccessSaveNewPaymentAddressState(savePaymentAddressModel: value));
    }).catchError((e) {
      emit(ErrorPaymentAddressState(e.toString()));
    });
  }
}
