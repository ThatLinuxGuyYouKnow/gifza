import 'package:gifza/screens/library.dart';
import 'package:gifza/screens/searchResults.dart';
import 'package:gifza/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:gifza/screens/home.dart';

enum AppScreen { home, settings, searchResults, library }

class ScreenProvider extends ChangeNotifier {
  Widget get currentScreenWidget {
    switch (currentScreen) {
      case AppScreen.home:
        return HomeScreen();
      case AppScreen.settings:
        return SettingsScreen();

      case AppScreen.searchResults:
        return SearchResultsScreen();

      case AppScreen.library:
        return LibraryScreen();
    }
  }

  AppScreen currentScreen = AppScreen.home;

  routeToScreen({required AppScreen screen}) {
    currentScreen = screen;
    notifyListeners();
  }
}
