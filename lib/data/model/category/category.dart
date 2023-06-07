class MainCategoryModel {
  int? success;
  List<Categories>? categories;

  MainCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    if (json["data"] != null) {
      List<Categories> list = [];
      json['data'].forEach((v) {
        list.add(Categories.fromJson(v));
      });
      categories = list;
    }
  }
}

class CategoryModel {
  int? success;
  CategoryDataModel? data;

  CategoryModel({this.success, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new CategoryDataModel.fromJson(json['data'])
        : null;
  }
}

class CategoryDataModel {
  int? id;
  String? name;
  String? description;
  String? image;
  String? originalImage;
  Filters? filters;
  String? seoUrl;
  List<SubCategories>? subCategories;

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    originalImage = json['original_image'];
    filters =
        json['filters'] != null ? new Filters.fromJson(json['filters']) : null;
    seoUrl = json['seo_url'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }
}

class Filters {
  List<String>? filterGroups;

  Filters({this.filterGroups});

  Filters.fromJson(Map<String, dynamic> json) {
    filterGroups = json['filter_groups'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_groups'] = this.filterGroups;
    return data;
  }
}

class SubCategories {
  int? categoryId;
  int? parentId;
  String? name;
  String? seoUrl;
  String? image;
  String? originalImage;
  Filters? filters;
  List<Categories>? categories;

  SubCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    parentId = json['parent_id'];
    name = json['name'];
    seoUrl = json['seo_url'];
    image = json['image'];
    originalImage = json['original_image'];
    filters =
        json['filters'] != null ? new Filters.fromJson(json['filters']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }
}

class Categories {
  int? categoryId;
  int? id;
  int? parentId;
  String? name;
  String? description;
  String? seoUrl;
  String? image;
  String? originalImage;
  Filters? filters;
  List<SubCategories>? subCategories;

  Categories.fromJson(Map<String, dynamic> json) {
    print("****** ${json}");
    categoryId = json['category_id'];
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    description = json["description"];
    seoUrl = json['seo_url'];
    image = json['image'];
    originalImage = json['original_image'];
    filters =
        json['filters'] != null ? Filters.fromJson(json['filters']) : null;
    if (json["sub_categories"] != null) {
      List<SubCategories> list = [];
      json["sub_categories"].forEach((v) {
        list.add(SubCategories.fromJson(v));
      });
      subCategories = list;
    }
  }
}
