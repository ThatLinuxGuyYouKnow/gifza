import 'package:flutter/material.dart';

class SuccesfulIndexAlert extends StatelessWidget {
  final String? annotation;
  const SuccesfulIndexAlert({super.key, this.annotation});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final String successText =
        "Added to your vault${annotation == null ? " !" : " with the tag ${annotation}"}";
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
