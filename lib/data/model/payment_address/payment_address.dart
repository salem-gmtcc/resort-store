class PaymentAddressModel {
  int? success;
  GetPaymentAddressModel? getPaymentAddressModel;

  PaymentAddressModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    getPaymentAddressModel = json["data"] != null
        ? GetPaymentAddressModel.fromJson(json["data"])
        : null;
  }
}

//TODO: Save New Payment Address &&  Send existing Payment Address

class SavePaymentAddressModel {
  int? success;
  List<String>? data;
  SavePaymentAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
  }
}

//TODO: get Payment Address
class GetPaymentAddressModel {
  String? addressId;
  List<PaymentListAddressModel>? paymentListAddressModel;

  GetPaymentAddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    if (json['addresses'] != null) {
      List<PaymentListAddressModel> list = [];
      json['addresses'].forEach((v) {
        list.add(PaymentListAddressModel.fromJson(v));
      });
      paymentListAddressModel = list;
    }
  }
}

class PaymentListAddressModel {
  String? addressId;
  String? firstname;
  String? lastname;
  String? company;
  String? address1;
  String? address2;
  String? postcode;
  String? city;
  String? zoneId;
  String? zone;
  String? zoneCode;
  String? countryId;
  String? country;
  String? isoCode2;
  String? isoCode3;
  String? addressFormat;

  PaymentListAddressModel.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    postcode = json['postcode'];
    city = json['city'];
    zoneId = json['zone_id'];
    zone = json['zone'];
    zoneCode = json['zone_code'];
    countryId = json['country_id'];
    country = json['country'];
    isoCode2 = json['iso_code_2'];
    isoCode3 = json['iso_code_3'];
    addressFormat = json['address_format'];
  }
}
