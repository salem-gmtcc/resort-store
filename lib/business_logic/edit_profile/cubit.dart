import 'package:resort_store/business_logic/edit_profile/state.dart';
import 'package:bloc/bloc.dart';

import '../../data/repository/edit_profile/edit_profile.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  final EditProfileRepository editProfileRepository;

  EditProfileCubit({required this.editProfileRepository})
      : super(InitEditProfileState());

  //TODO: Edit Profile
  editProfileCubit(Map<String, dynamic> body) {
    emit(LoadingEditProfileState());
    editProfileRepository.getEditProfileRepository(body).then((value) {
      emit(SuccessEditProfileState(editProfileModel: value));
    }).catchError((e) {
      emit(ErrorEditProfileState(e.toString()));
    });
  }

  //TODO: Change Password
  changePasswordCubit(Map<String, dynamic> body) {
    emit(LoadingEditProfileState());
    editProfileRepository.changePasswordRepository(body).then((value) {
      emit(SuccessEditProfileState(editProfileModel: value));
    }).catchError((e) {
      emit(ErrorEditProfileState(e.toString()));
    });
  }
}
