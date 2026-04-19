import 'package:flutter/material.dart';
import 'package:gifza/widgets/actionCards.dart';

class ActionRow extends StatelessWidget {
  const ActionRow({super.key});

  Widget build(BuildContext context) {
    return Container(
      height: 410,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UploadNewCard(
            onPressed: () {},
          ),
          LibraryActionCard(),
          RecentAssetsCard()
        ],
      ),
    );
  }
}
