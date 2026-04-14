import 'package:flutter/material.dart';
import 'package:gifza/themes/theme.dart';
import 'package:gifza/widgets/appbar.dart';
import 'package:gifza/providers/screenProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ScreenProvider())],
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget currentScreen = context.watch<ScreenProvider>().currentScreen;
    return MaterialApp(
        title: 'Gifza',
        theme: theme,
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: GifzaAppBar(),
          ),
          body: currentScreen,
        ));
  }
}
