import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData.light(),
      home: new HomePage(title: 'Nps Dart Sdk Flutter Example'),
    );
  }
}
