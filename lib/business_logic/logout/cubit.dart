import 'package:resort_store/business_logic/logout/state.dart';
import 'package:resort_store/data/repository/logout/logout.dart';
import 'package:bloc/bloc.dart';

class LogOutCubit extends Cubit<LogOutStates> {
  final LogoutRepository logoutRepository;

  LogOutCubit({required this.logoutRepository}) : super(LogOutInitState());

 Future getLogOut() async{
    emit(LogOutLoadingState());
    logoutRepository.logOutRepo().then((value) {
      emit(LogOutSuccessState(genericModel: value));
    }).catchError((e) {
      emit(LogOutErrorState(e.toString()));
    });
  }
}
