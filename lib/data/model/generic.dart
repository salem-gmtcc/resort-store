class GenericModel {
  int? success;
  List<String>? data ;
  List<String>? error ;

  GenericModel.fromJson(Map<String, dynamic> json) {
    print("******* $json");
  success = json['success'];
  error = json['error'].cast<String>();
  data = json['data'].cast<String>();
  }
}