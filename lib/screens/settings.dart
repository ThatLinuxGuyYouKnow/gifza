import 'package:flutter/material.dart';
import 'package:gifza/widgets/settingsTiles.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 300, vertical: 100),
        color: theme.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                  fontFamily: 'Vietnam',
                  fontSize: 40,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 30,
            ),
            SettingsTile(
                titleText: 'Auto Embed',
                subtitleText: 'Embed Images as they are uploaded',
                onRadioToggled: () {}),
            SizedBox(
              height: 30,
            ),
            SettingsTile(
                titleText: 'Save Searches',
                subtitleText: 'Save recent queries for quick searches',
                onRadioToggled: () {}),
            SizedBox(
              height: 30,
            ),
            SpecialActionTile(
              actionText: 'Re-index',
              titleText: 'Re-index',
              subtitleText: 'Re-index images',
              onRadioToggled: () {},
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              'Storage',
              style: TextStyle(
                  fontFamily: 'Vietnam',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: theme.secondary),
            ),
          ],
        ));
  }
}
