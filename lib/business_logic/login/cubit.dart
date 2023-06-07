import 'package:resort_store/business_logic/login/state.dart';
import 'package:resort_store/data/repository/login/login.dart';
import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit({required this.loginRepo}) : super(InitLoginState());
  final LoginRepo loginRepo;
  bool isSecure = true;

  changeSecureCubit() {
    isSecure =! isSecure;
    emit(ChangeSecureState());
  }

  Future login(Map<String, dynamic> body) async{
    emit(LoadingLoginState());
    loginRepo.getLoginRepo(body).then((value) {
      emit(SuccessLoginState(loginModel: value));
    }).catchError((e) {
      emit(ErrorLoginState(e: e.toString()));
    });
  }
}
