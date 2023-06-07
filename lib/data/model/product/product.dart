class ProductModel {
  int? success;
  List<ProductDataModel>? productDataModel;

  ProductModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    if (json["data"] != null) {
      List<ProductDataModel> list = [];
      json["data"].forEach((v) {
        list.add(ProductDataModel.fromJson(v));
      });
      productDataModel = list;
    }
  }
}

class ProductDetailsModel {
  int? success;
  ProductDataModel? productDataModel;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    productDataModel =
        json["data"] != null ? ProductDataModel.fromJson(json["data"]) : null;
  }
}

class CompareProductModel {
  int? success;
  List<ProductDataModel>? productDataModel;

  CompareProductModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    if (json["data"] != null) {
      List<ProductDataModel> list = [];
      json["data"].forEach((v) {
        list.add(ProductDataModel.fromJson(v));
      });
      productDataModel = list;
    }
  }
}

class FeaturedProductModel {
  int? success;
  List<FeaturedDataModel>? data;

  FeaturedProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FeaturedDataModel>[];
      json['data'].forEach((v) {
        if (v["products"] != null) {
          data!.add(FeaturedDataModel.fromJson(v));
          /* v["products"].forEach((x){
            print("-------------$x");
            data!.add(FeaturedDataModel.fromJson(x));
          });*/
        }
      });
      this.data = data;
    }
  }
}

class FeaturedDataModel {
  int? moduleId;
  String? name;
  String? code;
  List<ProductDataModel>? products;

  FeaturedDataModel.fromJson(Map<String, dynamic> json) {
    moduleId = json['module_id'];
    name = json['name'];
    code = json['code'];
    if (json['products'] != null) {
      List<ProductDataModel> list = [];
      json['products'].forEach((v) {
        list.add(ProductDataModel.fromJson(v));
      });
      products = list;
    }
  }
}

class ProductDataModel {
  int? id;
  int? productId;
  String? priceExcludingTax;
  String? name;
  String? taxAmount;
  int? special;
  String? manuFacture;
  String? model;
  String? image;
  String? originalImage;
  String? thumb;
  dynamic price;
  String? priceFormat;
  int? rating;
  String? description;
  String? stockStatus;
  String? dateAvailable;
  String? viewed;
  String? priceTax;
  QuantityOffers? quantityOffers;
  List<OptionValueModel>? optionValueModel;

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    priceExcludingTax = json["price_excluding_tax_formated"];
    special = json["special"];
    name = json["name"];
    taxAmount = json["tax_amount_formated"];
    manuFacture = json["manufacturer"];
    model = json["model"];
    price = json["price"];
    image = json["image"];
    originalImage = json["original_image"];
    thumb = json["thumb"] ?? thumb;
    priceFormat = json["price_formated"];
    rating = json["rating"];
    description = json["description"];
    stockStatus = json["stock_status"];
    dateAvailable = json["date_available"];
    viewed = json["viewed"];
    priceTax = json["special_excluding_tax_formated"];
    quantityOffers = json['quantity_offers'] != null
        ? QuantityOffers.fromJson(json['quantity_offers'])
        : null;



    // if (json["options"] != null) {
    //   List<OptionValueModel> list = [];
    //   json["options"].forEach((v) {
    //     print("______________________________________________________________________");
    //     list.add(OptionValueModel.fromJson(v));
    //   });
    //   optionValueModel = list;
    // }
  }
}

//TODO : Quantity offer
class QuantityOffers {
  List<QuantityOffersInit>? quantityOffersInit;
  String? statusQuantity;

  QuantityOffers.fromJson(Map<String, dynamic> json) {

    if (json['quantity_offers_init'] != null) {
      List<QuantityOffersInit> quantityOffersInit = [];
      json['quantity_offers_init'].forEach((v) {
        quantityOffersInit.add(new QuantityOffersInit.fromJson(v));
      });
      this.quantityOffersInit = quantityOffersInit;
    }
    statusQuantity = json["status_quantity"];
  }
}

class QuantityOffersInit {
  String? low;
  String? high;
  String? price;

  QuantityOffersInit.fromJson(Map<String, dynamic> json) {
    low = json['low'];
    high = json['high'];
    price = json['price'];
  }
}

//TODO : Build Tree

class OptionValueModel {
  int? productOptionId;
  String? required;
  int? optionId;
  List<OptionValue>? optionValue;
  List<OptionTree>? optionTree;

  OptionValueModel.fromJson(Map<String, dynamic> json) {
    productOptionId = json["product_option_id"];
    required = json["required"];
    optionId = json["option_id"];
    if (json["option_value"] != null) {
      List<OptionValue> list = [];
      json["option_value"].forEach((v) {
        list.add(OptionValue.fromJson(v));
      });
      optionValue = list;
    }
    if (json["value"] != null) {
      List<OptionTree> list = [];
      json["value"].forEach((v) {
        list.add(OptionTree.fromJson(v));
      });
      optionTree = list;
    }
  }
}

class OptionValue {
  int? productOptionId;
  int? optionValueId;
  String? name;
  int? quantity;
  String? priceFormated;

  OptionValue.fromJson(Map<String, dynamic> json) {
    productOptionId = json["product_option_value_id"];
    optionValueId = json["option_value_id"];
    name = json["name"];
    quantity = json["quantity"];
    priceFormated = json["price_formated"];
  }
}

class OptionTree {
  String? optionValueId;
  String? productOptionValueId;
  String? quantity;
  String? subtract;
  String? price;
  List<OptionTree>? children;

  OptionTree.fromJson(Map<String, dynamic> json) {
    optionValueId = json["option_value_id"];
    productOptionValueId = json["product_option_value_id"];
    quantity = json["quantity"];
    subtract = json["subtract"];
    price = json["price"];
  }
}
