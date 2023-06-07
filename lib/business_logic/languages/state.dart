import 'package:resort_store/data/model/languages/languages.dart';

abstract class LanguageStates {}

class LanguageInitState extends LanguageStates {}

class GetAllLanguageSuccessState extends LanguageStates {
  final LanguagesModel languagesModel;

  GetAllLanguageSuccessState({required this.languagesModel});
}

class GetOnlyLanguageInitState extends LanguageStates {
  final GetLanguageModel getLanguageModel;

  GetOnlyLanguageInitState({required this.getLanguageModel});
}

class LanguageErrorState extends LanguageStates {
  String? error;

  LanguageErrorState(this.error);
}

class LanguageLoadingState extends LanguageStates {}
