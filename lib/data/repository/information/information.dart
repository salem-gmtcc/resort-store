import 'package:resort_store/data/model/information/information.dart';
import 'package:resort_store/data/services/information/information.dart';

class InformationRepository {
  final InformationService informationService;

  InformationRepository({required this.informationService});

  Future<dynamic> getInformationRepository() async {
    final data = await informationService.getInformationService();
    if (data != null) {
      return Future(() => InformationModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }

  Future<dynamic> getOneInformationRepository(String id) async {
    final data = await informationService.getOneInformationService(id);
    if (data != null) {
      return Future(() => OneInformationModel.fromJson(data));
    } else {
      return Future(() => null);
    }
  }
}
