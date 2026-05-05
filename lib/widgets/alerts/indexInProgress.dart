import 'package:flutter/material.dart';

class IndexProgress extends StatelessWidget {
  final String? annotation;
  const IndexProgress({super.key, this.annotation});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final String inProgressText = "Indexing this asset";
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
                inProgressText,
                style: TextStyle(fontFamily: 'Jakarta', fontSize: 18),
              ),
              LinearProgressIndicator(
                color: theme.primary,
              )
            ]));
  }
}
