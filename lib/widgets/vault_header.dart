import 'package:flutter/material.dart';
import 'package:gifza/widgets/filter_pills.dart';

class VaultHeader extends StatelessWidget {
  const VaultHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Visual Vault',
                style: TextStyle(
                    fontFamily: 'Jakarta',
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w700)),
            Text('Show recently indexed and viewed photos and assets',
                style: TextStyle(
                    fontFamily: 'Jakarta',
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700))
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
            width: 10,
          ),
          FilterPill(
              filterText: 'Sort',
              onFilter: (value) {},
              filterIcon: Icon(Icons.sort))
        ])
      ],
    );
  }
}
