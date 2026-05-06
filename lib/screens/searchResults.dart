import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';
import 'package:gifza/providers/searchProvider.dart';
import 'package:gifza/widgets/assetCard.dart';
import 'package:gifza/widgets/homeLibrarySubsection.dart';
import 'package:provider/provider.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final List<AssetEntity> searchResults = searchProvider.assets;

    return searchResults.isNotEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 300),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        'Assets matching your search query',
                        style: TextStyle(
                            fontFamily: 'Jakarta',
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 3),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return AssetCard(asset: searchResults[index]);
                      }),
                )
              ],
            ),
          )
        : EmptyAssetState();
  }
}
