import 'dart:convert';

import 'package:resort_store/core/constants/api_constant.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/model/session/session.dart';
import 'package:resort_store/data/network/api_client.dart';

import '../../../core/constants/header.dart';

class SessionService {
  final ApiClient _apiClient;

  SessionService(this._apiClient);

  Future<SessionModel> getSessionId() async {
    final response = await _apiClient.post(
      ApiConstants.indexPhp,
      headers: {
        ApiConstants.secretKey : ApiConstants.secretKeyValue
      },
      parameters: {ApiConstants.route: "feed/rest_api/session"},
      baseUrl: ApiConstants.baseUrl,
    );
    if (response.body.isNotEmpty) {
      print("********** session Id ${response.body["data"]["session"]}");
      final res = SessionModel.fromJson(response.body);
      print("res ${res.data!.session}");
      return Future.value(res);
    } else {
      return Future.value(null);
    }
  }
}
