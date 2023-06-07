import 'package:resort_store/data/model/product/product.dart';
import 'package:flutter/material.dart';

abstract class ProductStates {}

class ProductInitState extends ProductStates {}

//TODO: ALL PRODUCT
class SuccessAllProductState extends ProductStates {
  final ProductModel productModel;

  SuccessAllProductState({required this.productModel});
}

//TODO: LATEST PRODUCT
class SuccessLatestProductState extends ProductStates {
  final ProductModel productModel;

  SuccessLatestProductState({required this.productModel});
}

//TODO: BEST SELLER  PRODUCT
class SuccessBestSellerProductState extends ProductStates {
  final ProductModel productModel;

  SuccessBestSellerProductState({required this.productModel});
}

//TODO: PRODUCT DETAILS
class SuccessProductDetailsState extends ProductStates {
  final ProductDetailsModel productDetailsModel;

  SuccessProductDetailsState({required this.productDetailsModel});
}

//TODO: PRODUCT RELATED
class SuccessProductRelatedState extends ProductStates {
  final ProductModel productModel;

  SuccessProductRelatedState({required this.productModel});
}

//TODO: FEATURED PRODUCT
class SuccessProductFeaturedState extends ProductStates {
  final List<ProductDataModel> products;

  SuccessProductFeaturedState({required this.products});
}

//TODO: COMPARE PRODUCT
class SuccessCompareProductState extends ProductStates {
  final CompareProductModel compareProductModel;

  SuccessCompareProductState({required this.compareProductModel});
}

//TODO: PRODUCT SEARCH
class SuccessProductSearchState extends ProductStates {
  final List<ProductDataModel> products;

  SuccessProductSearchState({required this.products});
}

class ProductErrorState extends ProductStates {
  final String e;

  ProductErrorState({required this.e});
}

class ProductLoadingState extends ProductStates {}

class ProductCompareLoadingState extends ProductStates {}


class ClearTextEditingController extends ProductStates {
  ClearTextEditingController();
}
