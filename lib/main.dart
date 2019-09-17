import 'package:flutter/material.dart';
import 'package:headphone_store/service_loactor.dart';

import 'pages/menu_home.dart';

void main() {
  setUpServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MenuHome(),
    );
  }
}
