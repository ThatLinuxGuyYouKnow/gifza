import 'package:gifza/screens/library.dart';

import 'package:gifza/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:gifza/screens/home.dart';

enum AppScreen { home, settings, library }

enum LibraryMode { search, fullLibrary, recent }

class ScreenProvider extends ChangeNotifier {
  LibraryMode? libraryMode;
  Widget get currentScreenWidget {
    switch (currentScreen) {
      case AppScreen.home:
        return HomeScreen();
      case AppScreen.settings:
        return SettingsScreen();

      case AppScreen.library:
        return LibraryScreen(
            libraryMode: libraryMode ?? LibraryMode.fullLibrary);
    }
  }

  AppScreen currentScreen = AppScreen.home;

  routeToScreen({required AppScreen screen, LibraryMode? mode}) {
    libraryMode = mode;
    currentScreen = screen;
    notifyListeners();
  }
}
