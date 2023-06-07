class CartModel {
  int? success;
  CartDataModel? cartDataModel;

  CartModel.fromJson(Map<String, dynamic> json) {

    print("************************");
    print(json);
    print("#" * 10);
    success = json["success"];
    cartDataModel = json["data"] != null ? CartDataModel.fromJson(json["data"]) : null;
  }
}

class SendDataToCart {
  int? success;
  CartProducts? cartProducts;

  SendDataToCart.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    cartProducts = json["product"] != null ? CartProducts.fromJson(json["product"]) : null;
  }
}

class CartDataModel {
  String? weight;
  List<CartProducts>? cartListProduct;
  String? total;
  int? totalProductCount;
  String? totalPrice;

  CartDataModel.fromJson(Map<String, dynamic> json) {
    print("2222222222222222222222222222222222222222");
    weight = json["weight"];
    if (json["products"] != null) {
      List<CartProducts> list = [];
      json["products"].forEach((v) {
        list.add(CartProducts.fromJson(v));
      });
      cartListProduct = list;
    }
    total = json["total"];
    totalProductCount = json["total_product_count"];
    totalPrice = json["total_price"];
  }
}

class CartProducts {
  String? key;
  String? thumb;
  String? name;
  String? productId;
  String? model;
  String? quantity;
  String? price;
  String? total;
  String? taxAmountFormated;
  num? totalRaw;

  CartProducts.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    print("* 1 $key");
    thumb = json["thumb"];
    taxAmountFormated = json["tax_amount_formated"];
    totalRaw = json["total_raw"];
    print("* 2 $thumb");
    name = json["name"];
    print("* 3 $name");
    productId = json["product_id"];
    print("* 4 $productId");
    model = json["model"];
    print("* 5 $model");
    quantity = json["quantity"];
    print("* 6 $quantity");
    price = json["price"];
    print("* 7 $price");
    total = json["total"];
  }
}

class EmptyCart {
  int? success;
  List<String>? error;
  List<String>? data;

  EmptyCart.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'].cast<String>();
    data = json['data'].cast<String>();
  }

}
