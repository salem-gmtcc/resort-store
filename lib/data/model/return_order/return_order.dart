class ReturnOrderModel {
  int? success;

  List<ReturnOrderDataModel>? data;

  ReturnOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['error'] != null) {
      if (json['data'] != null) {
        data = <ReturnOrderDataModel>[];
        json['data'].forEach((v) {
          data!.add(ReturnOrderDataModel.fromJson(v));
        });
      }
    }
  }
}






class ReturnOrderDetailsModel {
  ReturnOrderDataModel? returnOrderDataModel;

  ReturnOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    returnOrderDataModel = json["data"] != null
        ? ReturnOrderDataModel.fromJson(json["data"])
        : null;
  }
}

class ReturnOrderDataModel {
  int? id;
  String? returnId;
  String? orderId;
  String? name;
  String? status;
  String? dateAdded;
  String? dateOrdered;
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;
  String? product;
  String? model;
  String? quantity;
  String? reason;
  String? opened;
  String? comment;

  ReturnOrderDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    returnId = json['return_id'];
    orderId = json['order_id'];
    name = json['name'];
    status = json['status'];
    dateAdded = json['date_added'];
    dateOrdered = json['date_ordered'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    product = json['product'];
    model = json['model'];
    quantity = json['quantity'];
    reason = json['reason'];
    opened = json['opened'];
    comment = json['comment'];
  }
}

// class ReorderOrderModel {
//
//
//   int? success;
//   List<String>? error;
//   List<String>? data;
//   List<String>? message;
//
//
//   ReorderOrderModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     error = json['error'].cast<String>();
//     data = json['data'].cast<String>();
//     message = json['message'].cast<String>();
//   }
//
// }
