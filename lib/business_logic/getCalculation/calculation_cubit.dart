import 'package:resort_store/data/model/getCalculations/getCalculations.dart';
import 'package:resort_store/data/repository/getCalculations/getCalculations.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calculation_state.dart';

class CalculationCubit extends Cubit<CalculationState> {
  CalculationCubit({required this.getCalculationRepo})
      : super(CalculationInitial());
  final GetCalculationRepo getCalculationRepo;

  getCalculationData(String productId,CalculationBody calculationBody) {
    emit(CalculationLoadingState());
    getCalculationRepo.getCalculationRepo(productId,calculationBody).then((value) {
      emit(CalculationSuccessState(getCalculationsModel: value));
    }).catchError((e) {
      emit(CalculationErrorState(e.toString()));
    });
  }
}
