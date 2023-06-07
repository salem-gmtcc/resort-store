class Currencies {
  int? success;
  CurrenciesModel? currenciesModel;

  Currencies.fromJson(Map<String,dynamic> json){
    success = json["success"];
    currenciesModel =   json['data'] != null ? new CurrenciesModel.fromJson(json['data']) : null;
  }

}



class CurrenciesModel {

  List<CurrenciesDataModel>? currenciesDataModel;

  CurrenciesModel.fromJson(Map<String,dynamic> json){

    if (json['currencies'] != null) {
      currenciesDataModel = <CurrenciesDataModel>[];
      json['currencies'].forEach((v) {
        currenciesDataModel!.add(CurrenciesDataModel.fromJson(v));
      });
      this.currenciesDataModel = currenciesDataModel;
    }
  }
}



class CurrenciesDataModel {

  String? title;
  String? code;
  String? symbolLeft;
  String? symbolRight;

  CurrenciesDataModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    code = json['code'];
    symbolLeft = json['symbol_left'];
    symbolRight = json['symbol_right'];
  }

}