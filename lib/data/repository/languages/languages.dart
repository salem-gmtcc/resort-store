import 'package:resort_store/data/services/languages/languages.dart';

import '../../model/languages/languages.dart';

class LanguagesRepository {
  final LanguagesService languagesService;

  LanguagesRepository({required this.languagesService});

  //TODO: GET ALL LANGUAGES
  Future<dynamic> getLanguagesRepository() async {
    final data = await languagesService.getLanguagesService();
    if (data != null) {
      return Future.value(LanguagesModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }


  //TODO: GET ONLY LANGUAGES
  Future<dynamic> getOnlyLanguagesRepository(String id) async {
    final data = await languagesService.getLanguageService(id);
    if (data != null) {
      return Future.value(GetLanguageModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }


}
