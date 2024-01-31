import 'package:flutter_ecosphere/server/sql/base_sql.dart';
import 'package:flutter_ecosphere/server/util/token_util.dart';
import 'package:flutter_ecosphere/server/value/config_value.dart';

import '../../model/token.dart';

class LoginSQL extends BaseSQLModel{

  List<Token>? tokenList;

  // 私有构造函数
  LoginSQL._();

  // 单例实例
  static final LoginSQL _instance = LoginSQL._();

  // 获取单例实例的静态方法
  factory LoginSQL() => _instance;

  Future<String> createToken(int userId,String deviceId)async{
    String token = TokenUtil.createToken();
    //删掉旧token
    await execute('DELETE FROM token WHERE user_id = $userId;');
    //确认token过期时间
    var dateTime = DateTime
        .now()
        .add(Duration(days: ConfigValue.tokenValidityPeriod));
    //插入token
    var result = await execute(
        '''
INSERT INTO token (token, expiration_time, user_id, device_id)
VALUES ('$token', '${dateTime.toIso8601String()}', $userId, '$deviceId');
      '''
    );
    return token;
  }

  Future<String?> getToken(String token)async{
    var tokenList = await execute('''
SELECT * FROM token WHERE token = '$token';
    ''');
    return tokenList;
  }


}