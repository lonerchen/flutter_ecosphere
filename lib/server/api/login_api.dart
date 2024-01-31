

import 'base_api.dart';

class LoginApi extends BaseApi{

  @override
  bool get requireSign => false;

  static const login = 'login';

  static const register = 'register';

  @override
  List<String> apiList = [
    login,
    register,
  ];

}