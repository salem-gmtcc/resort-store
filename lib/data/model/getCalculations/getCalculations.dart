import 'package:flutter_map/flutter_map.dart';

class GetCalculationsModel {
  GetCalculationsData? getCalculationsData;

  GetCalculationsModel.fromJson(Map<String, dynamic> json) {
    getCalculationsData = json["data"] != null
        ? GetCalculationsData.fromJson(json["data"])
        : null;
  }
}

class GetCalculationsData {
  String? html;

  GetCalculationsData.fromJson(Map<String, dynamic> json) {
    html = json["html"];
  }
}

class CalculationBody {
  int? qty;

  String? price;

  CalculationBody({
    required this.qty,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['price'] = this.price;
    return data;
  }
}

