import 'package:resort_store/data/model/edit_profile/edit_profile.dart';
import 'package:resort_store/data/services/edit_profile/edit_profile.dart';

class EditProfileRepository {
  final EditProfileService editProfileService;
  EditProfileRepository({required this.editProfileService});
  //TODO: get Edit Profile
  Future<dynamic> getEditProfileRepository(Map<String,dynamic> body) async{
    final data = await editProfileService.getEditProfileService(body);

    if(data != null){
      return Future.value(EditProfileModel.fromJson(data));
    }else {
      return Future(() => null);
    }

  }

  //TODO: change password
  Future<dynamic> changePasswordRepository(Map<String,dynamic> body) async{
    final data = await editProfileService.changePasswordService(body);
    if(data != null){
      return Future.value(EditProfileModel.fromJson(data));
    }else {
      return Future(() => null);
    }
  }

}