

class HttpCode{

  static const ok = 200;

  static const requestNotSupported = 401;

  static const undefined = 402;

  static const paramMissing = 403;

  static const serverError = 410;

  static const userNotExist = 420;

  static const userPwdError = 421;

  static const userAlreadyExist = 422;

  static const userTokenExpired = 423;

  //通过code返回String
  static Map<int,String> codeStringMap = {
    ok : 'ok',
    requestNotSupported : '不支持该类型的请求',
    undefined : '方法未定义',
    paramMissing : '参数缺失',
    serverError : '服务器错误',
    userNotExist : '用户不存在',
    userPwdError : '密码错误',
    userAlreadyExist : '用户已存在',
    userTokenExpired : '登录过期',
  };

}