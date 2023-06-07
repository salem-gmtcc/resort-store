import 'package:resort_store/core/constants/strings_app.dart';

import '../helpers/shared_prefrencess.dart';
import 'api_constant.dart';

class HeaderApis {

 static String? sessionId = SharedHelper.sharedPreferences.getString(
      AppStrings.sessionId);
 static String? currencyCode = SharedHelper.sharedPreferences.getString(AppStrings.currencyCode);
 static String? headerLang = SharedHelper.sharedPreferences.getString(
      AppStrings.languageCode);

  static Map<String, String> headers = {
    ApiConstants.accept: "application/json",
    ApiConstants.secretKey: ApiConstants.secretKeyValue,
    ApiConstants.imageDimension: "1000x1000",
    ApiConstants.sessionId: sessionId!,
    ApiConstants.headerCurrencyCode: currencyCode ?? "SAR",
    ApiConstants.headerLanguage: headerLang ?? "en-gb",

  };
}
