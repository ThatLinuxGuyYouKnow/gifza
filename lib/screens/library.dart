import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';
import 'package:gifza/providers/screenProvider.dart';
import 'package:gifza/providers/searchProvider.dart';

import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/utils/deduplicateAssets.dart';
import 'package:gifza/utils/sortAssetsByDateIndexed.dart';
import 'package:gifza/widgets/assetCard.dart';
import 'package:gifza/widgets/filterPills.dart';
import 'package:gifza/widgets/homeLibrarySubsection.dart';
import 'package:provider/provider.dart';

/// re usable library component, because, search, full library and recent assets all very similar layout / functionality, we just use
/// one component for it and use conditional rendering
class LibraryScreen extends StatefulWidget {
  final LibraryMode libraryMode;
  const LibraryScreen({super.key, required this.libraryMode});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _sortOrder = 'desc';

  ///vary header text depending on library mode
  headerText(LibraryMode libraryMode) => switch (libraryMode) {
        LibraryMode.fullLibrary => "All your assets",
        LibraryMode.recent => "Assets you've recently added",
        LibraryMode.search => "Assets matching your search"
      };

  fillAssetBucket(LibraryMode libraryMode) => switch (libraryMode) {
        LibraryMode.fullLibrary ||
        LibraryMode.recent =>
          context.watch<ObjectBoxService>().assetsInStorage,
        LibraryMode.search =>
          Provider.of<SearchProvider>(context, listen: false).assets,
      };

  getEmptyMessage(LibraryMode mode) => switch (mode) {
        LibraryMode.fullLibrary ||
        LibraryMode.recent =>
          "No assets in your vault",
        LibraryMode.search => "No assets match your search query"
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    /// bucket of assets we'll be manipulating, will depend on library mode
    List<AssetEntity> assetBucket = fillAssetBucket(widget.libraryMode);

    final List<AssetEntity> deduplicatedAssets =
        deduplicateAssets(assets: assetBucket);

    final List<AssetEntity> sortedSavedAssets =
        sortAssets(assets: deduplicatedAssets, sortOrder: _sortOrder);

    final List<AssetEntity> finalAssets =
        widget.libraryMode == LibraryMode.recent
            ? sortedSavedAssets.take(10).toList()
            : sortedSavedAssets;

    return finalAssets.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(100),
            child: EmptyAssetState(
              message: getEmptyMessage(widget.libraryMode),
            ),
          )
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
                          itemCount: finalAssets.length,
                          itemBuilder: (context, index) {
                            return AssetCard(asset: finalAssets[index]);
                          })),
                ],
              ),
            ),
          );
  }
}
