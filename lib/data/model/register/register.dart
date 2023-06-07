class RegisterModel {
  int? success;

  RegisterModelData? registerModelData;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    print("*******");
    print("********* $json");
    success = json["success"];
    registerModelData = json["data"] != null ? RegisterModelData.fromJson(json["data"]) : null;
  }
}

class RegisterModelData {
  String? firstName;
  String? lastName;
  String? email;
  String? telephone;
  String? customGroupId;
  List<CustomerGroupData>? customerGroupData;
  String? company;
  int? customerId;
  String? addressId;

  RegisterModelData.fromJson(Map<String, dynamic> json) {
    firstName = json["firstname"];
    lastName = json["lastname"];
    email = json["email"];
    telephone = json["telephone"];
    customGroupId = json["customer_group_id"];
    if (json["customer_groups"] != null) {
      List<CustomerGroupData> list = [];
      json["customer_groups"].forEach((v) {
        list.add(CustomerGroupData.fromJson(v));
      });
      customerGroupData = list;
    }
    customerId = json["customer_id"];
    addressId = json["address_id"];
    company = json["company"];
  }
}

class CustomerGroupData {
  String? customGroupId;
  String? approval;
  String? sortOrder;
  String? languageId;
  String? name;
  String? desciption;

  CustomerGroupData.fromJson(Map<String, dynamic> json) {
    customGroupId = json["customer_group_id"];
    approval = json["approval"];
    sortOrder = json["sort_order"];
    languageId = json["language_id"];
    name = json["name"];
    desciption = json["description"];
  }
}
