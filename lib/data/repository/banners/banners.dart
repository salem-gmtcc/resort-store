import 'package:resort_store/data/model/banner/banner.dart';

import '../../services/banner/banner.dart';

class BannerRepository {
  final BannerService bannerService;

  BannerRepository({required this.bannerService});

  Future<dynamic> getBannerRepo(String id) async {
    final data = await bannerService.getBannerService(id);
    if (data != null) {
      return Future.value(BannerModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }
}
