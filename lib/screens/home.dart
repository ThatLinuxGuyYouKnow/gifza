import 'package:flutter/material.dart';

import 'package:gifza/widgets/action_row.dart';
import 'package:gifza/widgets/header_texts.dart';
import 'package:gifza/widgets/home_library_subsection.dart';
import 'package:gifza/widgets/searchbar.dart';
import 'package:gifza/widgets/vault_header.dart';

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
