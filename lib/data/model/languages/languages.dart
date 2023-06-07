class LanguagesModel {
  int? success;
  List<LanguageDataModel>? languageDataModel;

  LanguagesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      languageDataModel = <LanguageDataModel>[];
      json['data'].forEach((v) {
        languageDataModel!.add(LanguageDataModel.fromJson(v));
      });
      languageDataModel = languageDataModel;
    }
  }
}

class GetLanguageModel {
  int? success;
  LanguageDataModel? languageDataModel;

  GetLanguageModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    languageDataModel =
        json["data"] != null ? LanguageDataModel.fromJson(json["data"]) : null;
  }
}

class LanguageDataModel {
  dynamic languageId;
  String? name;
  String? code;
  String? locale;
  String? image;
  String? directory;
  String? sortOrder;
  String? status;

  LanguageDataModel.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    name = json['name'];
    code = json['code'];
    locale = json['locale'];
    image = json['image'];
    directory = json['directory'];
    sortOrder = json['sort_order'];
    status = json['status'];
  }
}
