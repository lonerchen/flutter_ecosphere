
//错误回调
import 'dart:convert';

import 'package:flutter_ecosphere/server/value/http_code_value.dart';

class HttpErrorModel{

  late int code;

  late String message;

  late int errorCode;

  HttpErrorModel(this.code, this.message, this.errorCode);

  HttpErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    errorCode = json['errorCode'];
  }

  HttpErrorModel.fromCode(this.code,{int? errCode}) {
    message = HttpCode.codeStringMap[code] ?? '未知错误';
    errorCode = errCode ?? code;
  }

  String toJsonString() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['errorCode'] = errorCode;
    return json.encode(data);
  }



}

//成功回调
class HttpOkModel{

  late int code;

  late String message;

  late dynamic data;

  HttpOkModel(this.code, this.message, this.data);

  HttpOkModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  String toJsonString() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['data'] = this.data;
    return json.encode(data);
  }

}