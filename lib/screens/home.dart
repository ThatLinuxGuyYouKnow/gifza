import 'package:flutter/material.dart';
import 'package:gifza/widgets/actionCards.dart';
import 'package:gifza/widgets/actionRow.dart';
import 'package:gifza/widgets/headerTexts.dart';
import 'package:gifza/widgets/searchbar.dart';
import 'package:gifza/widgets/vaultHeader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 300),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            HomeScreenHeader(),
            SizedBox(
              height: 50,
            ),
            GifzaSearchBar(),
            ActionRow(),
            VaultHeader()
          ],
        ),
      ),
    );
  }
}
