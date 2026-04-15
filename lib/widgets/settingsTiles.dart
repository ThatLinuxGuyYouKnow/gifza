import 'package:flutter/material.dart';
import 'package:gifza/themes/theme.dart';

class SettingsTile extends StatefulWidget {
  final String titleText;
  final String subtitleText;
  final Function onRadioToggled;

  const SettingsTile({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.onRadioToggled,
  });

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  bool _hovered = false;

  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() {
        _hovered = true;
      }),
      onExit: (_) => setState(() {
        _hovered = false;
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: _hovered ? Color(0xFF1A2744) : Color(0xFF141f38),
        ),
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.titleText,
                  style: TextStyle(
                      fontFamily: 'Vietnam',
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.subtitleText,
                  style: TextStyle(
                      fontFamily: 'Vietnam', fontSize: 15, color: Colors.grey),
                )
              ],
            ),
            Switch(
              value: true,
              onChanged: (_) {
                widget.onRadioToggled;
              },
              activeColor: scheme.primary,
              focusColor: Colors.white,
              activeTrackColor: scheme.primary.withOpacity(0.2),
            )
          ],
        ),
      ),
    );
  }
}

class SpecialActionTile extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final Function onRadioToggled;
  final String actionText;
  const SpecialActionTile(
      {super.key,
      required this.titleText,
      required this.subtitleText,
      required this.onRadioToggled,
      required this.actionText});

  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.primary, width: 1),
        borderRadius: BorderRadius.circular(40),
        color: Color(0xFF1A2744),
      ),
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: TextStyle(
                    fontFamily: 'Vietnam',
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                subtitleText,
                style: TextStyle(
                    fontFamily: 'Vietnam', fontSize: 15, color: Colors.grey),
              )
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(30)),
              height: 60,
              child: Center(
                child: Text(
                  actionText,
                  style: TextStyle(),
                ),
              ))
        ],
      ),
    );
  }
}
