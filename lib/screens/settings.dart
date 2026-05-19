// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/services/userPreferenceService.dart';
import 'package:gifza/widgets/alerts/loadingAlert.dart';
import 'package:gifza/widgets/alerts/successfulAlert.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double? _localTolerance;
  int? _localQueryMax;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final box = context.watch<ObjectBoxService>();
    final prefs = context.read<UserPreferenceService>();

    _localTolerance ??=
        prefs.getTolerancePref(toleranceType: ToleranceType.percentage) / 100;
    _localQueryMax ??= prefs.getMaxResultsPerQuery();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                      color: theme.primary,
                      fontFamily: 'Jakarta',
                      fontSize: 40,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'S E A R C H   T O L E R A N C E',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          SettingsPod(widgetChildren: [
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: SettingsSliderTile(
                  onChangedEnd: (value) =>
                      prefs.storeTolerancePref(toleranceSliderValue: value),
                  isPercentageType: true,
                  title: 'Search Tolerance',
                  subtitle: "Higher = Broader Results, Lower = Closer matches",
                  value: _localTolerance!,
                  min: 0.0,
                  max: 1.0,
                  leftLabel: 'Broad',
                  rightLabel: 'Strict',
                  onChanged: (value) {
                    setState(() {
                      _localTolerance = value;
                    });
                  },
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: SettingsSliderTile(
                onChangedEnd: (value) =>
                    prefs.storeMaxResultsPerQuery(maxResults: value.round()),
                isPercentageType: false,
                title: 'Max Results Per Query',
                subtitle:
                    'Maximum number of results to render on a single query',
                value: _localQueryMax!.toDouble() <= 20
                    ? _localQueryMax!.toDouble()
                    : 20,
                min: 2.0, // Minimum 10 results
                max: 20.0, // Maximum 100 results
                leftLabel: '2',
                rightLabel: '20',
                onChanged: (value) {
                  setState(() {
                    _localQueryMax = value.round();
                  });
                },
              ),
            )
          ]),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'V A U L T   M A N A G E M E N T',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          ReIndexTile(
              onReIndex: () {},
              onDeleteOrphaned: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LoadingAlert();
                    });
                final int assetsDeleted = box.prune();
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SuccesfulAlert(
                          successText: 'Pruned $assetsDeleted assets');
                    });
              }),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'D A N G E R   Z O N E',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          DeleteAllAssets(onDeleteAll: () {
            box.deletAllAssets();
          })
        ],
      ),
    );
  }
}

class SettingsPod extends StatelessWidget {
  final List<Widget> widgetChildren;
  const SettingsPod({super.key, required this.widgetChildren});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < widgetChildren.length; i++) ...[
            widgetChildren[i],

            // continue to put a divider after every widget child EXCEPT the very last one
            if (i < widgetChildren.length - 1) ...[
              Divider(
                color: Colors.white,
              )
            ]
          ]
        ],
      ),
    );
  }
}

class SettingsSliderTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangedEnd;
  final bool isPercentageType;

  // Added ranges and labels to make the slider reusable!
  final double min;
  final double max;
  final String leftLabel;
  final String rightLabel;

  const SettingsSliderTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.isPercentageType = false,
    this.min = 0.0,
    this.max = 1.0,
    this.leftLabel = '',
    this.rightLabel = '',
    required this.onChangedEnd,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontFamily: 'Jakarta',
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              Text(
                  isPercentageType
                      ? '${(value * 100).round()}%'
                      : '${value.round()}',
                  style: TextStyle(color: theme.primary))
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Slider(
            onChangeEnd: onChangedEnd,
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
            activeColor: theme.primary,
            inactiveColor: theme.primary.withOpacity(0.2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(leftLabel,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
              Text(rightLabel,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}

class ReIndexTile extends StatelessWidget {
  final VoidCallback onReIndex;
  final VoidCallback onDeleteOrphaned;

  const ReIndexTile({
    super.key,
    required this.onReIndex,
    required this.onDeleteOrphaned,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.primary),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prune Vault ',
                      style: TextStyle(
                          fontFamily: 'Jakarta',
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('Remove assets whose files no longer exist',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              GestureDetector(
                onTap: onDeleteOrphaned,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.primary.withOpacity(0.1)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('Prune',
                      style: TextStyle(
                          fontFamily: 'Jakarta',
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DeleteAllAssets extends StatelessWidget {
  final Function onDeleteAll;

  const DeleteAllAssets({super.key, required this.onDeleteAll});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delete All ',
                      style: TextStyle(
                          fontFamily: 'Jakarta',
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('Delete all assets in your vault',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              GestureDetector(
                onTap: () => onDeleteAll(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.withOpacity(0.1)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('Nuke',
                      style: TextStyle(
                          fontFamily: 'Jakarta',
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
