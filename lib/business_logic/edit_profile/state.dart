import 'package:resort_store/data/model/edit_profile/edit_profile.dart';

abstract class EditProfileStates {}

class InitEditProfileState extends EditProfileStates {}

class SuccessEditProfileState extends EditProfileStates {
  final EditProfileModel editProfileModel;
  SuccessEditProfileState({required this.editProfileModel});
}

class LoadingEditProfileState extends EditProfileStates {}

class ErrorEditProfileState extends EditProfileStates {
  String? e;

  ErrorEditProfileState(this.e);
}
