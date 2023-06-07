class BannerModel {
  int? success;
  List<BannerDataModel>? bannerDataModel;

  BannerModel.fromJson(Map<String, dynamic> json) {
    print("***************************** :");
    print("***************************** $json :");
    success = json["success"];
    if (json["data"] != null) {
      List<BannerDataModel> list = [];
      json["data"].forEach((v) {
        list.add(BannerDataModel.fromJson(v));
      });
      bannerDataModel = list;
    }
  }
}

class BannerDataModel {
  String? title;
  String? link;
  String? image;

  BannerDataModel.fromJson(Map<String, dynamic> json) {
    print("******** Banner Json $json ");
    title = json["title"];
    link = json["link"];
    image = json["image"];
  }
}
