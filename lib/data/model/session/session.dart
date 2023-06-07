class SessionModel {
  int? success;
  Data? data;

  SessionModel.fromJson(Map<String, dynamic> json) {

    success = json['success'];

    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? session;
  Data.fromJson(Map<String, dynamic> json) {
    session = json['session'];
  }
}