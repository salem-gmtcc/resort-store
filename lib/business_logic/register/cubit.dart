import 'package:resort_store/business_logic/register/state.dart';
import 'package:bloc/bloc.dart';

import '../../data/repository/register/register.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterRepository registerRepository;

  RegisterCubit({required this.registerRepository})
      : super(RegisterInitState());

  bool isSecure = true;
  bool confirmPass = true;

  changeSecureCubit() {
    isSecure =! isSecure;
    emit(ChangeSecureState());
  }

  changeSecureConfirmPassCubit() {
    confirmPass =! confirmPass;
    emit(ChangeSecureConfirmPassState());
  }

  registerCubit(Map<String, dynamic> body) {
    print("******* enter Cubit");
    emit(RegisterLoadingState());
    registerRepository.getRegisterRepository(body).then((value) {
      print("******* enter ---- ***");
      emit(RegisterSuccessState(registerModel: value));
    }).catchError((e) {
      emit(RegisterErrorState(e.toString()));
    });
  }
}
