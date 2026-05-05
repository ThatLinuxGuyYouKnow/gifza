import 'package:flutter/material.dart';

enum ToastType { success, passive, error }

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ToastService {
  void showToast(
      {required ToastType toastType,
      required String title,
      required String content}) {
    final context = navigatorKey.currentContext;

    // if a snackbar is currently being displayed, hide it first, we want to display another one
    showDialog(
        context: context!, builder: (BuildContext context) => AlertDialog());
  }
}



/* void showBanner({
  required ToastType toastType,
  required String title,
  required String content,
}) {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showMaterialBanner(MaterialBanner(
      leading: Icon(_iconFor(toastType), color: _colorFor(toastType)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(content),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () =>
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          child: const Text('Dismiss'),
        ),
      ],
    ));
}

IconData _iconFor(ToastType type) => switch (type) {
      ToastType.success => Icons.check_circle,
      ToastType.passive => Icons.info,
      ToastType.error => Icons.error,
    };

Color _colorFor(ToastType type) => switch (type) {
      ToastType.success => Colors.green,
      ToastType.passive => Colors.blue,
      ToastType.error => Colors.red,
    };
 */