import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String errorTitle;
  const ErrorAlert({super.key, required this.errorTitle});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: theme.surface,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            overflow: TextOverflow.fade,
            errorTitle,
            style: TextStyle(fontFamily: 'Jakarta', fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          Icon(Icons.error, color: Colors.red)
        ],
      ),
    );
  }
}
