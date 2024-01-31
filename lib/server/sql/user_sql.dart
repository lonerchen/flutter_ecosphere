
import 'package:flutter_ecosphere/server/sql/base_sql.dart';

class UserSQL extends BaseSQLModel{

  // 私有构造函数
  UserSQL._();

  // 单例实例
  static final UserSQL _instance = UserSQL._();

  // 获取单例实例的静态方法
  factory UserSQL() => _instance;

  Future<String?> getUserFormAccount(String account){
    return execute('SELECT * FROM users WHERE phone = $account;');
  }

  Future<String?> getUserFormId(String id){
    return execute('SELECT * FROM users WHERE id = $id;');
  }

  Future<String?> registerUser(String name,String phone,String pwd)async{
    var result = await execute(
        '''
INSERT INTO users (name, phone, password)
VALUES ('$name', '$phone', '$pwd');
      '''
    );
    return result;
  }

}