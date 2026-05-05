import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      color: theme.surface,
      child: Center(
        child: Text(
          'Gifza',
          style: TextStyle(
              color: theme.primary,
              fontFamily: 'Jakarta',
              letterSpacing: 0.5,
              fontSize: 80),
        ),
      ),
    );
  }
}
