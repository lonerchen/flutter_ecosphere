
import 'package:flutter_ecosphere/server/util/crypto_utils.dart';
import 'package:uuid/uuid.dart';

class TokenUtil{

  //创建一个新的token
  static String createToken(){
    var uuid = Uuid();
    var uuidToken = uuid.v4();
    var token = CryptoUtils.generateMD5(uuidToken);
    return token;
  }

}