import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gifza/providers/assetProvider.dart';
import 'package:gifza/providers/searchProvider.dart';
import 'package:gifza/screens/splashScreen.dart';
import 'package:gifza/services/embeddingService.dart';
import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/services/tokenizerService.dart';
import 'package:gifza/themes/theme.dart';
import 'package:gifza/widgets/appbar.dart';
import 'package:gifza/providers/screenProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GifzaApp());
}

class GifzaApp extends StatefulWidget {
  GifzaApp({super.key});

  @override
  State<GifzaApp> createState() => _GifzaAppState();
}

class _GifzaAppState extends State<GifzaApp> {
  bool _initialized = false;

  ObjectBoxService? _objectBoxService;
  EmbeddingService? _embeddingService;
  ClipTokenizerService? _clipTokenizerService;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    final objectBox = ObjectBoxService();

    final embeddingService = EmbeddingService();

    final tokenizer = ClipTokenizerService();

    /// initialize everything in parallel
    await Future.wait<void>([
      objectBox.initialize(),
      embeddingService.initialize(),
      tokenizer.init(),
    ]);

    if (!mounted) return;
    setState(() {
      _objectBoxService = objectBox;
      _embeddingService = embeddingService;
      _clipTokenizerService = tokenizer;
      _initialized = true;
    });
  }

  Widget build(BuildContext context) {
    if (!_initialized) {
      return MaterialApp(theme: theme, home: SplashScreen());
    }
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ScreenProvider(),
      ),
      ChangeNotifierProvider(create: (_) => AssetProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      Provider<ObjectBoxService>.value(
        value: _objectBoxService!,
      ),
      Provider<EmbeddingService>.value(value: _embeddingService!),
      Provider<ClipTokenizerService>.value(value: _clipTokenizerService!),
    ], child: MaterialApp(theme: theme, home: HomePage()));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Widget currentScreen =
        context.watch<ScreenProvider>().currentScreenWidget;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: GifzaAppBar(),
      ),
      body: currentScreen,
    );
  }
}
