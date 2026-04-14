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
              children: [
                Text('Your Visual Vault',
                    style: TextStyle(
                        fontFamily: 'Jakarta',
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w700))
              ],
            ),
          ),
          FilterPill(
            filterIcon: Icon(Icons.filter),
            filterText: 'Semantic Filter',
            onFilter: () {},
          )
        ],
      ),
    );
  }
}
