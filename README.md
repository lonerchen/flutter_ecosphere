# flutter_ecosphere

Flutter ecosphere

## 项目说明

本项目为创建Flutter一体化生态圈。跳脱出单一责任的开发，站在宏观角度开发生态项目。为个人开发者提供实现想法的架构

# 项目结构术语：
server: 服务器端相关代码，默认运行在Windows MocOS Linux端
mobile: 移动端代相关码，默认运行在Android Ios Fuchsia端
manager: 管理后台端，用于配置项目，默认运行在Web端

# 注意：
lib层级底下的server，mobile，manager文件夹一般用于存放对应平台适用代码
如全平台公用代码，直接放在lib下的文件夹，如model/http_model,减少代码的重复性，和可复用性，加快开发效率，跟减少对接成本

# 项目产品规划：
项目1.x版本规划
通用：
1.通用网络请求框架，封装dio
2.页面加载架构
3.登录注册模型
4.前端Theme规范

server：
1.基本的服务器配置。
2.基本的数据库配置。
3.提供可拓展性接口。
4.提供登录注册接口。
5.提供登录校验功能。
6.提供用户信息读取接口。

mobile：
1.登录注册页面模版，支持多方登录
2.首页TAB模版
3.个人信息页面模版，支持修改，上传头像等

manager：
1.管理后台登录页面
2.管理后台用户信息查看页面
3.管理后台操作用户功能