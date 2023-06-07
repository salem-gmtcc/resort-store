class EditProfileModel {
  int? success;
  List<String>? error;
  List<String>? data;


  EditProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'].cast<String>();
    data = json['data'].cast<String>();
  }
}