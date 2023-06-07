import 'package:resort_store/data/services/register/register.dart';

import '../../model/register/register.dart';

class RegisterRepository {
  final RegisterService registerService;

  RegisterRepository({required this.registerService});

  Future<dynamic> getRegisterRepository(Map<String, dynamic> body) async {
    print("************ enter");
    final data = await registerService.getRegisterService(body);
    print("data   $data" );
    if (data != null) {
      return Future.value(RegisterModel.fromJson(data));
    } else {
      return Future.value(null);
    }
  }
}
