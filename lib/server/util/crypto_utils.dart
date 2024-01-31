
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class CryptoUtils {
  // 生成 SHA256 哈希
  static String generateSHA256(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // 生成 MD5 哈希
  static String generateMD5(String input) {
    var bytes = utf8.encode(input);
    var digest = md5.convert(bytes);
    return digest.toString();
  }

  // 使用 Base64 编码
  static String encodeBase64(String input) {
    var bytes = utf8.encode(input);
    var base64Str = base64Encode(bytes);
    return base64Str;
  }

  // 使用 Base64 解码
  static String decodeBase64(String base64Str) {
    var decodedBytes = base64Decode(base64Str);
    return utf8.decode(decodedBytes);
  }


}