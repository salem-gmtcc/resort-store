import 'package:resort_store/business_logic/information/state.dart';
import 'package:resort_store/data/repository/information/information.dart';
import 'package:bloc/bloc.dart';

class InformationCubit extends Cubit<InformationStates> {
  final InformationRepository informationRepository;

  InformationCubit({required this.informationRepository})
      : super(InformationInitStates());

  getInformationCubit() {
    emit(InformationLoadingStates());
    informationRepository.getInformationRepository().then((value) {
      emit(InformationSuccessStates(informationModel: value));
    }).catchError((e) {
      emit(InformationErrorStates(e.toString()));
    });
  }

  getOneInformationCubit(String id) {
    emit(InformationLoadingStates());
    informationRepository.getOneInformationRepository(id).then((value) {
      emit(OneInformationSuccessStates(oneInformationModel: value));
    }).catchError((e) {
      emit(InformationErrorStates(e.toString()));
    });
  }
}
