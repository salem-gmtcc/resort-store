import 'package:resort_store/data/services/product/product.dart';

import '../../model/product/product.dart';

class ProductRepository {
  final ProductService productService;

  ProductRepository({required this.productService});

  //TODO: get All PRODUCT
  Future<dynamic> getAllProductRepo() async {
    final data = await productService.getAllProductService();
    if (data != null) {
      return Future.value(ProductModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO: getLatest PRODUCT
  Future<dynamic> getLatestProductRepo() async {
    final data = await productService.getLatestProductService();
    if (data != null) {
      return Future.value(ProductModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO: getBestSeller PRODUCT
  Future<dynamic> getBestSellerProductRepo() async {
    final data = await productService.getBestSellerProductService();
    if (data != null) {
      return Future.value(ProductModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO:  PRODUCT Details
  Future<dynamic> getProductDetailsRepo(String id) async {
    final data = await productService.getProductDetailsService(id);
    if (data != null) {
      return Future.value(ProductDetailsModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO:  PRODUCT Related
  Future<dynamic> getProductRelatedRepo(String id) async {
    final data = await productService.getProductRelatedService(id);
    if (data != null) {
      return Future.value(ProductModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO:  PRODUCT Search
  Future<List<ProductDataModel>> getProductSearchRepo(String query) async {
    final data = await productService.getProductSearchService(query);
    if (data != null) {
      return Future.value(
          data.map((e) => ProductDataModel.fromJson(e)).toList());
    } else {
      return Future.value([]);
    }
  }

  //TODO:  get Product by CategoryId
  Future<dynamic> getProductByCategoryId(String id) async {
    final data = await productService.getProductByCategoryIdService(id);
    if (data != null) {
      return Future.value(ProductModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

  //TODO:  get Featured Product
  Future<List<ProductDataModel>> getFeaturedProductRepo() async {
    final data = await productService.getFeaturedProductService();
    if (data != null) {
      final res = Future.value(data.map((e) => ProductDataModel.fromJson(e)).toList());
      return res;
    } else {
      return Future.value([]);
    }
  }

  //TODO:  get Featured Product
  Future<dynamic> getCompareProductRepo() async {
    final data = await productService.getCompareProductService();
    if (data != null) {
      return Future.value(CompareProductModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }
}
