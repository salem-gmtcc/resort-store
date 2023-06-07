class PaymentMethodModel {
  int? success;
  GetPaymentMethodModel? getPaymentMethodModel;

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    getPaymentMethodModel = json["data"] != null ? GetPaymentMethodModel.fromJson(json["data"])  : null;
  }
}

class SendPaymentMethodModel {
  int? success;
  List<String>? data;
  SendPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
  }
}



class GetPaymentMethodModel {
  List<PaymentMethodDataModel>? paymentMethodDataModel;

  GetPaymentMethodModel.fromJson(Map<String,dynamic> json){
    if (json["payment_methods"] != null) {
      List<PaymentMethodDataModel> list = [];
      json["payment_methods"].forEach((v) {
        list.add(PaymentMethodDataModel.fromJson(v));
      });
      paymentMethodDataModel = list;
    }
  }


}

class PaymentMethodDataModel {
  String? code;
  String? title;
  String? terms;
  String? sortOrder;

  PaymentMethodDataModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    title = json["title"];
    terms = json["terms"];
    sortOrder = json["sort_order"];
  }
}
