import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:gifza/screens/home.dart';

class ScreenProvider extends ChangeNotifier {
  Widget get currentScreen => _currentScreen;
  Widget _currentScreen = HomeScreen();

  routeToScreen({required Widget routeTo}) {
    _currentScreen = routeTo;
    notifyListeners();
  }
}
