import 'package:flutter/material.dart';
import 'package:gifza/themes/theme.dart';
import 'package:gifza/widgets/appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gifza',
        theme: theme,
        home: Scaffold(
          appBar: PreferredSize(
            child: GfizaAppBar(),
            preferredSize: Size.fromHeight(200),
          ),
        ));
  }
}
