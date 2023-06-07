import '../../data/model/category/category.dart';

abstract class CategoriesStates {}

class CategoriesInitState extends CategoriesStates {}

//TODO: All Categories
class AllCategoriesSuccessState extends CategoriesStates {
  final List<Categories> categories;
  AllCategoriesSuccessState({required this.categories});
}

//TODO: Main
class MainCategoriesSuccessState extends CategoriesStates {
  final List<Categories> mainCategories;

  MainCategoriesSuccessState({required this.mainCategories});
}

//TODO: Sub
class SubCategoriesSuccessState extends CategoriesStates {
  final CategoryModel categoryModel;

  SubCategoriesSuccessState({required this.categoryModel});
}

class CategoriesLoadingState extends CategoriesStates {}

class CategoriesLoadingDataState extends CategoriesStates {}

class CategoriesErrorState extends CategoriesStates {
  String e;

  CategoriesErrorState(this.e);
}
