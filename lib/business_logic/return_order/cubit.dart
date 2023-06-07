import 'package:resort_store/business_logic/return_order/state.dart';
import 'package:resort_store/data/repository/return_order/return_order.dart';
import 'package:bloc/bloc.dart';

class ReturnOrderCubit extends Cubit<ReturnOrderStates>{
  ReturnOrderRepository returnOrderRepository;
  ReturnOrderCubit({required this.returnOrderRepository}) : super(InitReturnOrderState());

  //TODO : GET RETURN ORDER CUBIT
  getReturnOrderCubit() {
    emit(LoadingReturnOrderState());
    returnOrderRepository.getReturnOrderRepository().then((value) {
      emit(SuccessReturnOrderState(returnOrderModel: value));
    }).catchError((error){
      emit(ErrorReturnOrderState(error.toString()));
    });
  }

  //TODO : GET RETURN ORDER Details CUBIT
  getReturnOrderDetailsCubit(String returnId) {
    emit(LoadingReturnOrderState());
    returnOrderRepository.getReturnOrderDetailsRepository(returnId).then((value) {
      emit(SuccessReturnOrderDetailsState(returnOrderDetailsModel: value));
    }).catchError((error){
      emit(ErrorReturnOrderState(error.toString()));
    });
  }

  //TODO : SEND RETURN ORDER  CUBIT
  sendReturnOrderCubit(Map<String, dynamic> body) {
    emit(LoadingReturnOrderState());
    returnOrderRepository.sendReturnOrderDetailsRepository(body).then((value) {
      emit(SuccessSendReturnOrderState(sendOrderReturnDataModel: value));
    }).catchError((error){
      emit(ErrorReturnOrderState(error.toString()));
    });
  }



  //TODO : reOrder ORDER  CUBIT
  reOrderOrderCubit(String orderId,String orderProductId) {
    emit(LoadingReturnOrderState());
    returnOrderRepository.reOrderOrderDetailsRepository(orderId,orderProductId).then((value) {
      emit(SuccessSendReturnOrderState(sendOrderReturnDataModel: value));
    }).catchError((error){
      emit(ErrorReturnOrderState(error.toString()));
    });
  }

}