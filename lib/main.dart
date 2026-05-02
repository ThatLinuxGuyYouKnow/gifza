import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gifza/providers/assetProvider.dart';
import 'package:gifza/services/embeddingService.dart';
import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/services/tokenizerService.dart';
import 'package:gifza/themes/theme.dart';
import 'package:gifza/widgets/appbar.dart';
import 'package:gifza/providers/screenProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ObjectBoxService objectBoxService = ObjectBoxService();
  await objectBoxService.initialize();

  final EmbeddingService embeddingService = EmbeddingService();
  await embeddingService.initialize();

  final ClipTokenizerService tokenizerService = ClipTokenizerService();
  tokenizerService.init();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ScreenProvider(),
      ),
      ChangeNotifierProvider(create: (_) => AssetProvider()),
      Provider<ObjectBoxService>.value(
        value: objectBoxService,
      ),

      Provider<EmbeddingService>.value(value:)
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget currentScreen =
        context.watch<ScreenProvider>().currentScreenWidget;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gifza',
        theme: theme,
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: GifzaAppBar(),
          ),
          body: currentScreen,
        ));
  }
}
