import 'package:resort_store/data/model/currencies/currencies.dart';
import 'package:resort_store/data/repository/currencies/currencies.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'currencies_state.dart';


class CurrenciesCubit extends Cubit<CurrenciesState> {
  CurrenciesCubit({required this.currenciesRepo}) : super(CurrenciesInitial());
  final CurrenciesRepo currenciesRepo;

  getCurrenciesCubit() {
    emit(CurrenciesLoadingState());
    currenciesRepo.getCurrenciesRepo().then((value) {
      print("value ::: $value");
      emit(CurrenciesSuccessState(currencies: value));
    }).catchError((e) {
      emit(CurrenciesErrorState(error: e.toString()));
    });
  }
}
