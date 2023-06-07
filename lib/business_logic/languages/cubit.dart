import 'package:resort_store/business_logic/languages/state.dart';
import 'package:resort_store/data/repository/languages/languages.dart';
import 'package:bloc/bloc.dart';

class LanguagesCubit extends Cubit<LanguageStates> {
  final LanguagesRepository languagesRepository;

  LanguagesCubit({required this.languagesRepository})
      : super(LanguageInitState());

  //TODO : GET ALL Languages
  getAllLanguagesCubit() {
    emit(LanguageLoadingState());
    languagesRepository.getLanguagesRepository().then((value) {
      emit(GetAllLanguageSuccessState(languagesModel: value));
    }).catchError((e) {
      emit(LanguageErrorState(e.toString()));
    });
  }

  //TODO : GET only Language
  getOnlyLanguagesCubit(String id) {
    emit(LanguageLoadingState());
    languagesRepository.getOnlyLanguagesRepository(id).then((value) {
      emit(GetOnlyLanguageInitState(getLanguageModel: value));
    }).catchError((e) {
      emit(LanguageErrorState(e.toString()));
    });
  }
}
