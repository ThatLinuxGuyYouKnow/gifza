import 'package:flutter/material.dart';
import 'package:gifza/widgets/filterPills.dart';

class VaultHeader extends StatelessWidget {
  VaultHeader({super.key});

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
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
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            FilterPill(
              filterIcon: Icon(Icons.filter),
              filterText: 'Semantic Filter',
              onFilter: () {},
            ),
            SizedBox(
              width: 10,
            ),
            FilterPill(
                filterText: 'Sort',
                onFilter: () {},
                filterIcon: Icon(Icons.sort))
          ])
        ],
      ),
    );
  }
}
