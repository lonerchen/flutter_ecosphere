
import 'package:flutter/material.dart';

class ServerHomePage extends StatefulWidget {
  const ServerHomePage({super.key});

  @override
  State<ServerHomePage> createState() => _ServerHomePageState();
}

class _ServerHomePageState extends State<ServerHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('服务器首页'),
      ),
    );
  }

}
