import 'package:resort_store/data/model/getCalculations/getCalculations.dart';
import 'package:resort_store/data/services/getCalculations/getCalculations.dart';

class GetCalculationRepo{
  final GetCalculationServices getCalculationServices;
  GetCalculationRepo(this.getCalculationServices);


  Future<dynamic> getCalculationRepo(String productId,CalculationBody calculationBody) async {
    final data =  await getCalculationServices.getCalculationService(productId,calculationBody);
    if(data != null ){
      print("---------_____________--------- $data");
      return Future(() => GetCalculationsModel.fromJson(data));
    }else {
      return Future.value(null);
    }
  }

}