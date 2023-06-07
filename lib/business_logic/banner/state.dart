import 'package:resort_store/data/model/banner/banner.dart';

abstract class BannerStates {}

class BannerInitState extends BannerStates {}

class BannerSuccessState extends BannerStates {
  final BannerModel bannerModel;

  BannerSuccessState({required this.bannerModel});
}

class BannerErrorState extends BannerStates {
  final String e;

  BannerErrorState(this.e);
}

class BannerLoadingState extends BannerStates {}
