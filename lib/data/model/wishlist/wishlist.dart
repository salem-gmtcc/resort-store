class WishListModel {
  int? success;

  List<WishListDataModel>? data;


  WishListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <WishListDataModel>[];
      json['data'].forEach((v) {
        data!.add( WishListDataModel.fromJson(v));
      });
    }
  }
}



class WishListDataModel {
  String? productId;
  String? productSeoUrl;
  String? thumb;
  String? name;
  String? model;
  String? stock;
  String? price;
  int? special;


  WishListDataModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productSeoUrl = json['product_seo_url'];
    thumb = json['thumb'];
    name = json['name'];
    model = json['model'];
    stock = json['stock'];
    price = json['price'];
    special = json['special'];
  }
}