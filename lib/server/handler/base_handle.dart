

import 'dart:convert';

import 'package:flutter_ecosphere/model/https.dart';
import 'package:flutter_ecosphere/model/token.dart';
import 'package:flutter_ecosphere/server/sql/login_sql.dart';
import 'package:flutter_ecosphere/server/value/http_code_value.dart';
import 'package:shelf/shelf.dart';

import '../api/base_api.dart';
import '../api/login_api.dart';
import '../api/user_api.dart';

abstract class BaseHandler{

  Map<String,Object> jsonHeader = {
    "Content-Type":"application/json"
  };

  Map<String,Object> steamHeader = {
    "Content-Type":"multipart/form-data"
  };

  List<BaseApi> apiList = [
    LoginApi(),
    UserApi(),
  ];

  String get local;

  Future<Response> get(Request request)async{
    // todo 校验签名方法待填写
    var signCheck = false;
    var apiLastName = request.url.pathSegments.last;
    for(BaseApi baseApi in apiList){
      if(baseApi.requireSign) {
        if (baseApi.apiList.map((e) => e.split('/').last).contains(apiLastName)) {
          signCheck = true;
        }
      }
    }
    if(signCheck){
      var token = request.headers['token'];
      if(token != null) {
        var result = await LoginSQL().getToken(token);
        //判断token是否存在
        if(result != null){
          var jsonList = json.decode(result);
          if(jsonList is List && jsonList.isNotEmpty) {
            var token = Token.fromJson(jsonList[0]);
            //判断是否过期
            if(DateTime.parse(token.expiration_time).isAfter(DateTime.now())){
              //过期的话返回过期错误
              return Response.badRequest(
                  body: HttpErrorModel(
                      HttpCode.undefined,
                      HttpCode.codeStringMap[HttpCode.undefined] ?? '',
                      HttpCode.undefined
                  ).toJsonString(),
                  headers: jsonHeader
              );
            }else{
              return Response.badRequest(
                  body: HttpErrorModel(
                      HttpCode.userTokenExpired,
                      HttpCode.codeStringMap[HttpCode.userTokenExpired] ?? '',
                      HttpCode.userTokenExpired
                  ).toJsonString(),
                  headers: jsonHeader
              );
            }
          }
        }
      }
    }
    // 通过映射，执行到具体的方法
    InstanceMirror instanceMirror = reflect(this);
    var methodName  = request.url.pathSegments.last;
    // 使用invoke方法调用特定的方法
    if (instanceMirror.type.declarations.containsKey(Symbol(methodName))) {
      var result = instanceMirror.invoke(Symbol(methodName), [request]);
      if(result.reflectee is Future<Response>){
        return result.reflectee as Future<Response>;
      }
    } else {
      print('${request.url.path} not found');
    }
    return Response.badRequest(
        body: HttpErrorModel(
            HttpCode.undefined,
            HttpCode.codeStringMap[HttpCode.undefined] ?? '',
            HttpCode.undefined
        ).toJsonString(),
        headers: jsonHeader
    );
  }

  Future<Response> post(Request request)async{
    // todo 校验签名方法待填写
    var signCheck = true;
    // 通过映射，执行到具体的方法
    InstanceMirror instanceMirror = reflect(this);
    var methodName  = request.url.pathSegments.last;
    // 使用invoke方法调用特定的方法
    if (instanceMirror.type.declarations.containsKey(Symbol(methodName))) {
      var result = instanceMirror.invoke(Symbol(methodName), [request]);
      if(result.reflectee is Future<Response>){
        return result.reflectee as Future<Response>;
      }
    } else {
      print('${request.url.path} not found');
    }
    return Response.badRequest(
        body: HttpErrorModel(
            HttpCode.undefined,
            HttpCode.codeStringMap[HttpCode.undefined] ?? '',
            HttpCode.undefined
        ).toJsonString(),
      headers: jsonHeader
    );
  }



}