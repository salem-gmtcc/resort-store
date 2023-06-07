import 'package:resort_store/data/model/currencies/currencies.dart';
import 'package:resort_store/data/services/currencies/currencies.dart';

class CurrenciesRepo {
  final CurrenciesService currenciesService;

  CurrenciesRepo({required this.currenciesService});

  Future<dynamic> getCurrenciesRepo() async {
    final data = await currenciesService.getCurrenciesService();

    if (data != null) {
      print("data :   ${data}");
      print("data :   ${Currencies.fromJson(data)}");
      final result = Currencies.fromJson(data);
      print("result   ${result.currenciesModel!.currenciesDataModel![0].title}");
      return Future.value(result);
    } else {
      return Future(() => null);
    }
  }
}
