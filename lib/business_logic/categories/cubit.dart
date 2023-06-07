import 'package:resort_store/business_logic/categories/state.dart';
import 'package:resort_store/data/model/category/category.dart';
import 'package:resort_store/data/repository/categories/categories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  final CategoriesRepository categoriesRepository;

  CategoriesCubit({required this.categoriesRepository})
      : super(CategoriesInitState());
  int page = 1;
  List<Categories> oldListCategories = [];
  bool isLoading = false;

  //TODO: GET All CATEGORIES
  getAllCategories() {
    print("************************************************************  ----------- 1 ");
    emit(CategoriesLoadingDataState());
    categoriesRepository.getAllCategoriesRepo(page).then((value) {
      emit(AllCategoriesSuccessState(categories: value));
    }).catchError((e) {
      print("*********** all categories $e");
      emit(CategoriesErrorState(e.toString()));
    });
  }

  //TODO: GET MAIN CATEGORIES
  getMainCategories() {
    print("************************************************************  ----------- 2 ");
    emit(CategoriesLoadingState());
    categoriesRepository.getMainCategoriesRepo().then((value) {
      emit(MainCategoriesSuccessState(mainCategories: value));
    }).catchError((e) {
      print("*********** main categories $e");
      emit(CategoriesErrorState(e));
    });
  }



  //TODO: GET SUB CATEGORIES
  getSubCategories(String id) {
    print("************************************************************  ----------- 3");
    emit(CategoriesLoadingState());
    categoriesRepository.getSubCategoriesRepo(id).then((value) {
      emit(SubCategoriesSuccessState(categoryModel: value));
    }).catchError((e) {
      emit(CategoriesErrorState(e.toString()));
    });
  }
}
