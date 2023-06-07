abstract class CounterStates {}

class InitCounterState extends CounterStates {}


class ChangeCounterState extends CounterStates {
  int count;
  ChangeCounterState({required this.count});
}
