import 'package:flutter/material.dart';
import 'package:gifza/themes/theme.dart';

class GfizaAppBar extends StatelessWidget {
  GfizaAppBar({super.key});

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
        backgroundColor: theme.canvasColor,
        title: Text('Gfiza', style: textTheme.copyWith().titleMedium));
  }
}
