

import 'base_api.dart';

class UserApi extends BaseApi{

  static const String getUser = 'getUser';

  @override
  bool get requireSign => true;

  @override
  List<String> apiList = [
    getUser,
  ];

}