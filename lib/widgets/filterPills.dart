import 'package:flutter/material.dart';

class FilterPill extends StatelessWidget {
  final String filterText;
  final Function onFilter;
  final Icon filterIcon;
  const FilterPill(
      {super.key,
      required this.filterText,
      required this.onFilter,
      required this.filterIcon});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 50,
      width: 190,
      decoration: BoxDecoration(
          color: Color(0xFF141f38), borderRadius: BorderRadius.circular(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          filterIcon,
          Text(filterText),
        ],
      ),
    );
  }
}
