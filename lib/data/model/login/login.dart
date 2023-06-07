class LoginModel {
  int? success;

  LoginDataModel? data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? LoginDataModel.fromJson(json['data']) : null;
  }
}

class LoginDataModel {
  String? customerId;
  String? customerGroupId;
  String? storeId;
  String? languageId;
  String? firstname;
  String? lastname;
  String? email;
  String? telephone;
  String? fax;
  List<String>? wishlist;
  String? newsletter;
  String? addressId;
  String? ip;
  String? status;
  String? safe;
  String? code;
  String? dateAdded;
  List<String>? customFields;
  String? wishlistTotal;
  int? cartCountProducts;

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerGroupId = json['customer_group_id'];
    storeId = json['store_id'];
    languageId = json['language_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    telephone = json['telephone'];
    fax = json['fax'];
    newsletter = json['newsletter'];
    addressId = json['address_id'];
    ip = json['ip'];
    status = json['status'];
    safe = json['safe'];
    code = json['code'];
    dateAdded = json['date_added'];
    wishlistTotal = json['wishlist_total'];
    cartCountProducts = json['cart_count_products'];
  }
}
