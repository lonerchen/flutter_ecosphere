
import 'dart:convert';

import 'package:flutter_ecosphere/model/https.dart';
import 'package:flutter_ecosphere/model/user.dart';
import 'package:flutter_ecosphere/server/handler/base_handle.dart';
import 'package:flutter_ecosphere/server/sql/login_sql.dart';
import 'package:flutter_ecosphere/server/sql/user_sql.dart';
import 'package:flutter_ecosphere/server/value/http_code_value.dart';
import 'package:shelf/src/request.dart';
import 'package:shelf/src/response.dart';

class LoginHandler extends BaseHandler{

  @override
  String get local => "api/login";

  Future<Response> login(Request request)async{

    var phone = request.url.queryParameters['phone'];
    var pwd = request.url.queryParameters['password'];

    if(phone == null || pwd == null){
      return Response(
          HttpCode.paramMissing,
          body:HttpErrorModel.fromCode(HttpCode.paramMissing).toJsonString(),
          headers: jsonHeader
      );
    }
    var userString = await UserSQL().getUserFormAccount(phone);
    var userJson = json.decode(userString ?? '');
    if(userJson is List && userJson.isNotEmpty) {
      User user = User.fromJson(userJson[0]);
      //密码错误
      if (user.password == pwd) {
        var token = await LoginSQL().createToken(user.id, 'test');
        if (token != null) {
          return Response(HttpCode.ok,
              body: HttpOkModel(HttpCode.ok, 'ok', token).toJsonString(),
              headers: jsonHeader);
        }
      }else{
        return Response(
            HttpCode.userPwdError,
            body:HttpErrorModel.fromCode(HttpCode.userPwdError).toJsonString(),
            headers: jsonHeader
        );
      }
    }

    return Response(HttpCode.ok,body:HttpErrorModel.fromCode(HttpCode.userNotExist).toJsonString(),headers: jsonHeader);

  }

  Future<Response> register(Request request)async{
    //判断参数是否传了
    var name = request.url.queryParameters['name'];
    var phone = request.url.queryParameters['phone'];
    var pwd = request.url.queryParameters['password'];
    if(name == null || phone == null || pwd == null){
      return Response(
          HttpCode.paramMissing,
          body:HttpErrorModel.fromCode(HttpCode.paramMissing).toJsonString(),
          headers: jsonHeader
      );
    }
    var userString = await UserSQL().getUserFormAccount(phone);
    print('userString = $userString');
    if(userString == null || userString == '[]'){
      var token = await UserSQL().registerUser(name, phone, pwd);
      if(token != null){
        return Response(
            HttpCode.ok,
            body:HttpOkModel(HttpCode.ok, 'ok', 'ok').toJsonString(),
            headers: jsonHeader
        );
      }
    }else{
      return Response(
          HttpCode.ok,
          body:HttpErrorModel.fromCode(HttpCode.userAlreadyExist).toJsonString(),
          headers: jsonHeader
      );
    }
    return Response(HttpCode.serverError,body:HttpErrorModel.fromCode(HttpCode.serverError).toJsonString(),headers: jsonHeader);
  }


}