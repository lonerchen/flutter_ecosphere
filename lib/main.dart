import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ecosphere/enum/platform_enum.dart';
import 'package:flutter_ecosphere/server/server_main.dart';

bool isWeb = const bool.fromEnvironment('dart.library.js_util');

//判断启动项目类型
PlatformEnum platformEnum =
    isWeb ? PlatformEnum.manager
        : (Platform.isIOS || Platform.isAndroid || Platform.isFuchsia) ? PlatformEnum.mobile
        : (Platform.isWindows || Platform.isMacOS || Platform.isLinux) ? PlatformEnum.server
        : PlatformEnum.error;

void main() {

  if(platformEnum == PlatformEnum.server){
    //运行后端可视化工具
    runApp(const ServerMainPage());
  }else if(platformEnum == PlatformEnum.mobile){
    //运行移动端app
    // runApp();
  }else if(platformEnum == PlatformEnum.manager){
    //运行管理后台app
    // runApp();
  }

}
