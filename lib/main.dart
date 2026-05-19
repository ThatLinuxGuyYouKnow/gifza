import 'package:flutter/material.dart';
import 'package:gifza/providers/asset_provider.dart';
import 'package:gifza/providers/search_provider.dart';
import 'package:gifza/screens/splash_screen.dart';
import 'package:gifza/services/embedding_service.dart';
import 'package:gifza/services/object_box_service.dart';
import 'package:gifza/services/tokenizer_service.dart';
import 'package:gifza/services/user_preference_service.dart';
import 'package:gifza/themes/theme.dart';
import 'package:gifza/widgets/appbar.dart';
import 'package:gifza/providers/screen_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GifzaApp());
}

class GifzaApp extends StatefulWidget {
  const GifzaApp({super.key});

  @override
  State<GifzaApp> createState() => _GifzaAppState();
}

class _GifzaAppState extends State<GifzaApp> {
  bool _initialized = false;

  ObjectBoxService? _objectBoxService;
  EmbeddingService? _embeddingService;
  ClipTokenizerService? _clipTokenizerService;
  UserPreferenceService? _prefs;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    final objectBox = ObjectBoxService();

    final embeddingService = EmbeddingService();

    final tokenizer = ClipTokenizerService();

    final prefs = UserPreferenceService();

    /// initialize everything in parallel
    await Future.wait<void>([
      objectBox.initialize(),
      embeddingService.initialize(),
      tokenizer.init(),
      prefs.init()
    ]);

    if (!mounted) return;
    setState(() {
      _objectBoxService = objectBox;
      _embeddingService = embeddingService;
      _clipTokenizerService = tokenizer;
      _initialized = true;
      _prefs = prefs;
    });
  }

  @override
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
      Provider<UserPreferenceService>.value(value: _prefs!),
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
