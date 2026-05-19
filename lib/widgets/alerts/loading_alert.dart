import 'package:flutter/material.dart';

class LoadingAlert extends StatelessWidget {
  const LoadingAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: theme.surface,
      content: Container(
        height: 200,
        width: 100,
        child: CircularProgressIndicator(
          padding: EdgeInsets.all(30),
          strokeWidth: 15,
          color: theme.primary,
        ),
      ),
    );
  }
}
