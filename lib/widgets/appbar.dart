import 'package:flutter/material.dart';

class GifzaAppBar extends StatelessWidget {
  GifzaAppBar({super.key});

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: scheme.primary.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 2,
              offset: Offset(0, 4))
        ]),
        child: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: scheme.surface,
          elevation: 2,
          title: Row(children: [Text('Gifza', style: textTheme.titleMedium)]),
        ));
  }
}
