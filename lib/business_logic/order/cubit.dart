import 'package:resort_store/business_logic/order/state.dart';
import 'package:resort_store/data/repository/order/order.dart';
import 'package:bloc/bloc.dart';

class OrderCubit extends Cubit<OrderStates> {
  final ConfirmOrderRepository confirmOrderRepository;

  OrderCubit({required this.confirmOrderRepository}) : super(OrderInitState());

  //TODO: get All Orders
  getOrdersCubit() async {
    emit(OrderLoadingState());
    confirmOrderRepository.getOrdersRepository().then((value) {
      print("value $value");
      emit(GetAllOrdersSuccessState(getOrderModel: value));
    }).catchError((e) {
      emit(OrderErrorState(e.toString()));
    });
  }

  //TODO: get Order Details
  getOrderDetailsCubit(String orderId) async {
    emit(OrderLoadingState());
    confirmOrderRepository.getOrderDetailsRepository(orderId).then((value) {
      print("value $value");
      emit(GetDetailsOrdersSuccessState(orderDetailsModel: value));
    }).catchError((e) {
      emit(OrderErrorState(e.toString()));
    });
  }

  //TODO: confirm Order in Checkout Screen
  Future confirmOrderCubit() async {
    emit(OrderLoadingState());
    confirmOrderRepository.getConfirmOrderRepository().then((value) {
      print("value $value");
      emit(OrderSuccessState(confirmOrderModel: value));
    }).catchError((e) {
      emit(OrderErrorState(e.toString()));
    });
  }

  //TODO: confirm final Order in Checkout Screen
  confirmFinalOrderCubit() async {
    print("********* / ***** enter confirm cubit");
    emit(OrderLoadingState());
    confirmOrderRepository.getFinalConfirmOrderRepository().then((value) {
      print("value $value");
      emit(FinalOrderSuccessState());
    }).catchError((e) {
      emit(OrderErrorState(e.toString()));
    });
  }

  //TODO: reorder order
  reOrderOrderCubit(String orderId, String orderProductId) async {
    emit(OrderLoadingState());
    confirmOrderRepository
        .reorderOrderRepository(orderId, orderProductId)
        .then((value) {
      emit(ReOrderOrderState(reorderOrderModel: value));
    }).catchError((e) {
      emit(OrderErrorState(e.toString()));
    });
  }

  //TODO : send  return Order
  sendOrderReturnCubit(Map<String,dynamic> body) {
    emit(OrderLoadingState());
    confirmOrderRepository.sendOrderReturnRepository(body).then((value) {
      emit(SendReturnOrderState(sendOrderReturnDataModel: value));
    }).catchError((e) {
      emit(OrderErrorState(e.toString()));
    });
  }
}
