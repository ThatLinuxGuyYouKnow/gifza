import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';

import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/widgets/assetCard.dart';
import 'package:gifza/widgets/homeLibrarySubsection.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final List<AssetEntity> allSavedAssets =
        context.read<ObjectBoxService>().assetsInStorage;
    return allSavedAssets.isEmpty
        ? EmptyAssetState()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 300),
            color: theme.surface,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'All your assets',
                        style: TextStyle(
                            fontFamily: 'Jakarta',
                            fontSize: 30,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: allSavedAssets.length,
                          itemBuilder: (context, index) {
                            return AssetCard(asset: allSavedAssets[index]);
                          })),
                ],
              ),
            ),
          );
  }
}
