import 'package:mechaniconnect/core/class/crud.dart';
import 'package:mechaniconnect/link_api.dart';

class AuthData {
  Crud crud;
  AuthData(this.crud);

 
  register(
    String fullName,
    String email,
    String password,
  ) async {
    var response = await crud.postData(AppLink.register, {
      "fullName": fullName,
      "email": email,
      "password": password,
    });

    return response.fold((l) => l, (r) => r);
  }

 
  login(
    String email,
    String password,
  ) async {
    var response = await crud.postData(AppLink.login, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }

 
}
