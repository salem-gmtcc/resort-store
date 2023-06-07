import 'package:resort_store/business_logic/counter/state.dart';
import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(InitCounterState());
  int _count = 0;

  //TODO : Change Item Count

  int get count {
    return _count;
  }

  addItemCountCubit() {
    _count++;
    print("---------------------------add count in cubit  ${_count}");
    emit(ChangeCounterState(count: _count));

    print("---------------------------After Emit Counter State");
  }

  removeItemCountCubit() {
    _count--;
    print("---------------------------remove count in cubit  ${_count}");
    emit(ChangeCounterState(count: _count));
  }
}
