import 'package:resort_store/business_logic/login/state.dart';
import 'package:resort_store/business_logic/product/state.dart';
import 'package:resort_store/data/repository/product/product.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit({required this.productRepository}) : super(ProductInitState());
  final ProductRepository productRepository;
  TextEditingController? text = TextEditingController();

  void clearSearchTextController(){
      text!.clear();
      emit(ClearTextEditingController());
  }

  //TODO: get All Product Cubit
  getAllProductCubit() {
    emit(ProductLoadingState());
    productRepository.getAllProductRepo().then((value) {
      emit(SuccessAllProductState(productModel: value));
    }).catchError((e) {
      print("******************** ________________ ERROR : $e");
      emit(ProductErrorState(e: e.toString()));
    });
  }

  //TODO: getLatest Product Cubit
  getLatestProductCubit() {
    emit(ProductLoadingState());
    productRepository.getLatestProductRepo().then((value) {
      emit(SuccessLatestProductState(productModel: value));
    }).catchError((e) {
      emit(ProductErrorState(e: e.toString()));
    });
  }

  //TODO: getBestSeller Product Cubit
  getBestSellerProductCubit() {
    emit(ProductLoadingState());
    productRepository.getBestSellerProductRepo().then((value) {
      emit(SuccessBestSellerProductState(productModel: value));
    }).catchError((e) {
      emit(ProductErrorState(e: e.toString()));
    });
  }

  //TODO: get Product  Details Cubit
  getProductDetailsCubit(String id) {
    emit(ProductLoadingState());
    productRepository.getProductDetailsRepo(id).then((value) {
      emit(SuccessProductDetailsState(productDetailsModel: value));
    }).catchError((e) {
      emit(ProductErrorState(e: e.toString()));
    });
  }



  //TODO: get Related  Product Cubit
  getRelatedProductCubit(String id) {
    emit(ProductLoadingState());
    productRepository.getProductRelatedRepo(id).then((value) {
      emit(SuccessProductRelatedState(productModel: value));
    }).catchError((e) {
      emit(ProductErrorState(e: e.toString()));
    });
  }

  //TODO: get Search Product Cubit
  getSearchProductCubit(String query) {

    emit(ProductLoadingState());
    productRepository.getProductSearchRepo(query).then((value) {
      emit(SuccessProductSearchState(products: value));
    }).catchError((e) {
      emit(ProductErrorState(e: e.toString()));
    });
  }

  //TODO : get List of Products by CategoryID
  getProductByCategoryIdCubit(String id) {
    emit(ProductLoadingState());
    productRepository.getProductByCategoryId(id).then((value) {
      emit(SuccessAllProductState(productModel: value));
    }).catchError((e) {
      emit(ProductErrorState(e: e.toString()));
    });
  }

  //TODO : get Featured Products
  getFeaturedProductCubit() {
    emit(ProductLoadingState());
    productRepository.getFeaturedProductRepo().then((value) {
      print("****************** $value");
      emit(SuccessProductFeaturedState(products: value));
    }).catchError((e) {
      emit(ProductErrorState(e: e.toString()));
    });
  }

  //TODO : get Compare Products
  getCompareProductCubit() {
    emit(ProductCompareLoadingState());
    productRepository.getCompareProductRepo().then((value) {
      emit(SuccessCompareProductState(compareProductModel: value));
    }).catchError((e) {
      print("error :${e.toString()}");
      emit(ProductErrorState(e: e.toString()));
    });
  }

  //TODO : remove Compare Products
  /*removeCompareProductCubit(String id) {
    emit(ProductCompareLoadingState());
    productRepository.getCompareProductRepo(id).then((value) {
      emit(SuccessCompareProductState(compareProductModel: value));
    }).catchError((e) {
      print("error :${e.toString()}");
      emit(ProductErrorState(e: e.toString()));
    });
  }*/


}
