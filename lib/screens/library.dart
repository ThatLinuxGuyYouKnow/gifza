import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';
import 'package:gifza/providers/screenProvider.dart';
import 'package:gifza/providers/searchProvider.dart';

import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/utils/sortAssetsByDateIndexed.dart';
import 'package:gifza/widgets/assetCard.dart';
import 'package:gifza/widgets/filterPills.dart';
import 'package:gifza/widgets/homeLibrarySubsection.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  final LibraryMode libraryMode;
  const LibraryScreen({super.key, required this.libraryMode});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _sortOrder = 'desc';
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final objectBox = context.read<ObjectBoxService>();

    ///vary header text depending on library mode
    String headerText(LibraryMode libraryMode) => switch (libraryMode) {
          LibraryMode.fullLibrary => "All your assets",
          LibraryMode.recent => "Assets you've recently added",
          LibraryMode.search => "Assets matching your search"
        };

    fillAssetBucket(LibraryMode libraryMode) => switch (libraryMode) {
          LibraryMode.fullLibrary =>
            context.watch<ObjectBoxService>().assetsInStorage,
          LibraryMode.search =>
            Provider.of<SearchProvider>(context, listen: false).assets,
          LibraryMode.recent => context
              .read<ObjectBoxService>()
              .assetsInStorage
              .asMap()
              .entries
              .where((entry) => entry.key % 4 == 0)
              .map((entry) => entry.value)
              .toList()
        };

    /// bucket of assets we'll be manipulating, will depend on library mode
    List<AssetEntity> assetBucket = fillAssetBucket(widget.libraryMode);

    final List<AssetEntity> deduplicatedAssets =
        objectBox.deduplicateAssets(results: assetBucket);

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
                          headerText(widget.libraryMode),
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
