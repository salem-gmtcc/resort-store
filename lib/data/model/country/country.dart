class CountryModel {
  int? success;
  List<CountryDataModel>? countryDataModel;

  CountryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      List<CountryDataModel> list = [];
      json['data'].forEach((v) {
        list.add(CountryDataModel.fromJson(v));
      });
      countryDataModel = list ;
    }
  }
}

class ZoneModel {
  int? success;
  CountryDataModel? countryDataModel;

  ZoneModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    countryDataModel =
        json["data"] != null ? CountryDataModel.fromJson(json["data"]) : null;
  }
}

class CountryDataModel {
  int? countryId;
  String? name;
  String? isoCode2;
  String? isoCode3;
  String? addressFormat;
  String? postcodeRequired;
  String? status;

  CountryDataModel.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    name = json['name'];
    isoCode2 = json['iso_code_2'];
    isoCode3 = json['iso_code_3'];
    addressFormat = json['address_format'];
    postcodeRequired = json['postcode_required'];
    status = json['status'];
  }
}
