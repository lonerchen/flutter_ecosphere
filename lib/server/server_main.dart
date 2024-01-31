

import 'package:flutter/material.dart';
import 'package:flutter_ecosphere/server/page/server_home_page.dart';

class ServerMainPage extends StatefulWidget {

  const ServerMainPage({super.key});

  @override
  State<ServerMainPage> createState() => _ServerMainPageState();

}

class _ServerMainPageState extends State<ServerMainPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter生态服务器',
      home: ServerHomePage(),
    );
  }



}
