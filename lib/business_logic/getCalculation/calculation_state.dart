part of 'calculation_cubit.dart';

@immutable
abstract class CalculationState {}

class CalculationInitial extends CalculationState {}

class CalculationSuccessState extends CalculationState {
  final GetCalculationsModel? getCalculationsModel;
  CalculationSuccessState({required this.getCalculationsModel});
}

class CalculationErrorState extends CalculationState {
  final String?  error;
   CalculationErrorState(this.error);
 }

class CalculationLoadingState extends CalculationState {}
