part of 'currencies_cubit.dart';

@immutable
abstract class CurrenciesState {}

class CurrenciesInitial extends CurrenciesState {}

class CurrenciesSuccessState extends CurrenciesState {
  final Currencies currencies;

  CurrenciesSuccessState({required this.currencies});
}

class CurrenciesErrorState extends CurrenciesState {
  final String error;

  CurrenciesErrorState({required this.error});
}

class CurrenciesLoadingState extends CurrenciesState {}

class ChangeCurrencyCode extends CurrenciesState {
  final String code;

  ChangeCurrencyCode({required this.code});
}
