import 'package:flutter_ecosphere/server/handler/base_handle.dart';
import 'package:flutter_ecosphere/server/value/http_code_value.dart';
import 'package:shelf/src/request.dart';
import 'package:shelf/src/response.dart';

class UserHandler extends BaseHandler{

  @override
  String get local => "api/user";

  Future<Response> getUser(Request request)async{
    return Response(HttpCode.ok,headers: jsonHeader);
  }


}