import 'package:flutter/material.dart';

import 'package:gifza/widgets/actionRow.dart';
import 'package:gifza/widgets/headerTexts.dart';
import 'package:gifza/widgets/homeLibrarySubsection.dart';
import 'package:gifza/widgets/searchbar.dart';
import 'package:gifza/widgets/vaultHeader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 300),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
              VaultHeader(),
              HomeLibrarySubsection(),
            ],
          ),
        ),
      ),
    );
  }
}
