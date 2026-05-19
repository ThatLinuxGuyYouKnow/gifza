import 'package:flutter/material.dart';

class SuccesfulAlert extends StatelessWidget {
  final String successText;
  const SuccesfulAlert({super.key, required this.successText});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return AlertDialog(
        backgroundColor: theme.surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20)),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                successText,
                style: TextStyle(fontFamily: 'Jakarta', fontSize: 18),
              ),
              Icon(size: 30, Icons.done, color: theme.primary)
            ]));
  }
}
