import 'package:resort_store/data/model/product/product.dart';

import '../return_order/return_order.dart';

class ConfirmOrderModel {
  int? success;
  List<String>? error;
  ConfirmDataOrder? confirmDataOrder;

  ConfirmOrderModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    error = json['error'].cast<String>();
    confirmDataOrder =
        json["data"] != null ? ConfirmDataOrder.fromJson(json["data"]) : null;
  }
}

class ConfirmDataOrder {
  String? payment;
  dynamic orderId;
  List<ProductDataModel>? products;

  ConfirmDataOrder.fromJson(Map<String, dynamic> json) {
    payment = json["payment"];
    orderId = json["order_id"];
    if (json["products"] != null) {
      List<ProductDataModel> list = [];
      json["products"].forEach((v) {
        list.add(ProductDataModel.fromJson(v));
      });
      products = list;
    }
  }
}

class GetOrderModel {
  List<OrderDataModel>? orderDataModel;
  List<String>? error;
  int? totalProductCount;

  GetOrderModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      List<OrderDataModel> list = [];
      json["data"].forEach((v) {
        list.add(OrderDataModel.fromJson(v));
      });
      orderDataModel = list;
    }
    error = json['error'].cast<String>();
    totalProductCount = json["total_product_count"];

  }
}

class OrderDetailsModel {
  int? success;
  List<String>? error;
  GetOrderDetailsModel? getOrderDetailsModel;


  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    error = json['error'].cast<String>();
    getOrderDetailsModel = json["data"] != null
        ? GetOrderDetailsModel.fromJson(json["data"])
        : null;

  }
}

class GetOrderDetailsModel {
  String? orderId;
  String? storeName;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? paymentFirstname;
  String? paymentLastname;
  String? paymentCompany;
  String? paymentAddress1;
  String? paymentAddress2;
  String? paymentPostCode;
  String? paymentCity;
  String? paymentZoneId;
  String? paymentZone;
  String? paymentZoneCode;
  String? paymentCountryId;
  String? paymentCountry;
  String? paymentMethod;
  String? shippingFirstname;
  String? shippingLastname;
  String? shippingCompany;
  String? shippingAddress1;
  String? shippingAddress2;
  String? shippingPostCode;
  String? shippingCity;
  String? shippingZoneId;
  String? shippingZone;
  String? shippingZoneCode;
  String? shippingCountryId;
  String? shippingCountry;
  String? shippingMethod;
  List<OrderDataModel>? products;
  List<OrderHistoriesModel>? orderHistories;
  String? dateModified;

  GetOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderId = json["order_id"];
    storeName = json["store_name"];
    if (json["products"] != null) {
      List<OrderDataModel> list = [];
      json["products"].forEach((v) {
        list.add(OrderDataModel.fromJson(v));
      });
      products = list;
    }
    if (json["histories"] != null) {
      List<OrderHistoriesModel> list = [];
      json["histories"].forEach((v) {
        list.add(OrderHistoriesModel.fromJson(v));
      });
      orderHistories = list;
    }

    firstName = json["firstname"];
    lastName = json["lastname"];
    phone = json["telephone"];
    email = json["email"];
    paymentLastname = json['payment_lastname'];
    paymentCompany = json['payment_company'];
    paymentAddress1 = json['payment_address_1'];
    paymentAddress2 = json['payment_address_2'];
    paymentPostCode = json['payment_postcode'];
    paymentCity = json['payment_city'];
    paymentZoneId = json['payment_zone_id'];
    paymentZone = json['payment_zone'];
    paymentZoneCode = json['payment_zone_code'];
    paymentCountryId = json['payment_country_id'];
    paymentCountry = json['payment_country'];
    paymentMethod = json['payment_method'];
    shippingFirstname = json['shipping_firstname'];
    shippingLastname = json['shipping_lastname'];
    shippingCompany = json['shipping_company'];
    shippingAddress1 = json['shipping_address_1'];
    shippingAddress2 = json['shipping_address_2'];
    shippingPostCode = json['shipping_postcode'];
    shippingCity = json['shipping_city'];
    shippingZoneId = json['shipping_zone_id'];
    shippingZone = json['shipping_zone'];
    shippingZoneCode = json['shipping_zone_code'];
    shippingCountryId = json['shipping_country_id'];
    shippingCountry = json['shipping_country'];
    shippingMethod = json["shipping_method"];
    dateModified = json["date_modified"];
  }
}

class OrderDataModel {
  String? orderId;
  String? productId;
  String? orderProductId;
  String? model;
  String? quantity;
  String? price;
  String? name;
  String? status;
  String? dataAdded;
  int? products;
  String? total;

  OrderDataModel.fromJson(Map<String, dynamic> json) {
    orderId = json["order_id"];
    productId = json["product_id"];
    orderProductId = json["order_product_id"];
    model = json["model"];
    quantity = json["quantity"];
    price = json["price"];
    name = json["name"];
    status = json["status"];
    dataAdded = json["date_added"];
    products = json["products"];
    total = json["total"];
  }
}

class OrderHistoriesModel {
  String? dateAdded;
  String? status;
  String? comment;

  OrderHistoriesModel.fromJson(Map<String, dynamic> json) {
    dateAdded = json['date_added'];
    status = json['status'];
    comment = json['comment'];
  }
}

class ReorderOrderModel {
  int? success;
  List<String>? error;
  List<String>? data;
  List<String>? message;

  ReorderOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'].cast<String>();
    data = json['data'].cast<String>();
    message = json['message'].cast<String>();
  }
}

class SendOrderReturnDataModel {
  int? success;
  ReturnOrderDataModel? returnOrderDataModel;

  SendOrderReturnDataModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    returnOrderDataModel = json["data"] != null
        ? ReturnOrderDataModel.fromJson(json["data"])
        : null;
  }
}
