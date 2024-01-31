

import 'package:flutter/cupertino.dart';
import 'package:flutter_ecosphere/config/server_config.dart';
import 'package:flutter_ecosphere/model/https.dart';
import 'package:flutter_ecosphere/server/handler/base_handle.dart';
import 'package:flutter_ecosphere/server/handler/login_handler.dart';
import 'package:flutter_ecosphere/server/handler/user_handler.dart';
import 'package:flutter_ecosphere/server/value/http_code_value.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:sky_engine/_http/http.dart';

class ServerProvider extends ChangeNotifier{

  HttpServer? server;

  Future<void> startServer()async{
    if(server == null) {
      var handler = const Pipeline().addMiddleware(
          logRequests()
      ).addHandler(
          await _echoRequest
      );
      //挂载服务器
      server = await serve(handler, ServerConfig.domain, ServerConfig.port);
      //启用内容压缩
      server?.autoCompress = true;

      print('Serving at http://${server?.address.host}:${server?.port}');
    }
  }

  LoginHandler loginHandler = LoginHandler();
  UserHandler userHandler = UserHandler();


  Map<String,BaseHandler> _handlers = {
    loginHandler.local:loginHandler,
    userHandler.local:userHandler,
  };

  Future<Response> _echoRequest(Request request)async{
    // In an imaginary routing middleware...
    var component = request.url.pathSegments.first;

    print("请求方法：${request.method}");
    print("请求头：${request.headers}");
    print("请求路径：${request.url.path}");
    print("请求参数：${request.url.queryParameters}");
    print("请求component：$component");

    var handler = _handlers[component];
    if (handler == null) return Response.notFound(null);

    if(request.method == "GET"){
      return handler.get(request);
    }else if(request.method == "POST"){
      return handler.post(request);
    }else{
      return Response.badRequest(
          body: HttpErrorModel(
              HttpCode.requestNotSupported,
              HttpCode.codeStringMap[HttpCode.requestNotSupported] ?? '',
              HttpCode.requestNotSupported
          ).toJsonString()
      );
    }

  }

}