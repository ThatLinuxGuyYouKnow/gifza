import 'package:gifza/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:gifza/screens/home.dart';

enum AppScreen { home, settings }

class ScreenProvider extends ChangeNotifier {
  Widget get currentScreenWidget {
    switch (currentScreen) {
      case AppScreen.home:
        return HomeScreen();
      case AppScreen.settings:
        return SettingsScreen();
    }
  }

  AppScreen currentScreen = AppScreen.home;

  routeToScreen({required AppScreen screen}) {
    currentScreen = screen;
    notifyListeners();
  }
}
