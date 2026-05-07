import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';

import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/utils/sortAssetsByDateIndexed.dart';
import 'package:gifza/widgets/assetCard.dart';
import 'package:gifza/widgets/filterPills.dart';
import 'package:gifza/widgets/homeLibrarySubsection.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _sortOrder = 'desc';
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final objectBox = context.read<ObjectBoxService>();

    final allSavedAssets = context.watch<ObjectBoxService>().assetsInStorage;
    final List<AssetEntity> deduplicatedAssets =
        objectBox.deduplicateAssets(results: allSavedAssets);

    final List<AssetEntity> sortedSavedAssets =
        sortAssets(assets: deduplicatedAssets, sortOrder: _sortOrder);

    return deduplicatedAssets.isEmpty
        ? EmptyAssetState()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 300),
            color: theme.surface,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All your assets',
                          style: TextStyle(
                              fontFamily: 'Jakarta',
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            FilterPill(
                                filterText: 'Sort',
                                onFilter: (value) {
                                  setState(() {
                                    _sortOrder = value;
                                  });
                                },
                                filterIcon: Icon(Icons.sort))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: sortedSavedAssets.length,
                          itemBuilder: (context, index) {
                            return AssetCard(asset: sortedSavedAssets[index]);
                          })),
                ],
              ),
            ),
          );
  }
}
