import 'package:resort_store/business_logic/banner/state.dart';
import 'package:resort_store/data/repository/banners/banners.dart';
import 'package:bloc/bloc.dart';

class BannerCubit extends Cubit<BannerStates> {
  BannerCubit({required this.bannerRepository}) : super(BannerInitState());
  final BannerRepository bannerRepository;

  getBannerCubit(String id ) {
    emit(BannerLoadingState());
    bannerRepository.getBannerRepo(id).then((value) {
      emit(BannerSuccessState(bannerModel: value));
    }).catchError((e) {
      emit(BannerErrorState(e.toString()));
    });
  }
}
