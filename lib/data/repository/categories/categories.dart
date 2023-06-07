import '../../model/category/category.dart';
import '../../services/categories/categories.dart';

class CategoriesRepository {
  final CategoriesService categoriesService;

  CategoriesRepository({required this.categoriesService});

  // TODO: Get All CATEGORIES
  Future<List<Categories>> getAllCategoriesRepo(int page) async {
    final data = await categoriesService.getAllCategories(page);
    if (data != null) {
      final res = data.map((e) => Categories.fromJson(e)).toList();
      return Future.value(res);
    } else {
      return Future.value([]);
    }
  }



  // TODO: Get Main CATEGORIES
  Future<List<Categories>> getMainCategoriesRepo() async {
    final data = await categoriesService.getMainCategories();
    if (data != null) {
      return Future.value(data.map((e) => Categories.fromJson(e)).toList());
    } else {
      return Future.value([]);
    }
  }
  //TODO: Get Sub Category
  Future<dynamic> getSubCategoriesRepo( String id) async {
    final data = await categoriesService.getSubCategories(id);
    if (data != null) {
      return Future.value(CategoryModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }

}
