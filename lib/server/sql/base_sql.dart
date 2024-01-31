
//数据库实现类都需要基于这个类
import 'dart:convert';

import 'package:mysql1/mysql1.dart';

abstract class BaseSQLModel{

  MySqlConnection? sql;

  Future<String?> execute(String sqlString)async{
    String? jsonData;
    try{
      var settings = ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'Sxk8621324',
        db: 'test',
        characterSet: CharacterSet.UTF8MB4,
      );
      sql = await MySqlConnection.connect(settings);

      // await sql?.query("SELECT * FROM users WHERE id = $userId;");
      // final results = await sql?.query("SELECT * FROM users WHERE id = $userId;");
      if(sqlString.toUpperCase().startsWith('SELECT')) {
        await sql?.query("$sqlString");
      }
      final results = await sql?.query("$sqlString");
      final jsonList = [];
      for (var row in results!) {
        var rowData = <String,dynamic>{};
        //处理时间类型
        row.fields.forEach((key, value) {
          if(value is DateTime){
            rowData[key] = value.millisecondsSinceEpoch;
          }else{
            rowData[key] = value;
          }
        });
        jsonList.add(rowData);
      }
      jsonData = json.encode(jsonList);
      print(jsonData);
    }catch(e){
      print(e.toString());
    }finally{
      await sql?.close();
    }
    return jsonData;
  }


}