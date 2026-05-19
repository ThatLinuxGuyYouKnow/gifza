import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gifza/models/asset_entity.dart';
import 'package:gifza/services/object_box_setup.dart';
import 'package:gifza/utils/deduplicate_assets.dart';
import '../objectbox.g.dart';

class ObjectBoxService {
  late final Store store;
  late final Box<AssetEntity> box;

  initialize() async {
    final objectBox = await ObjectBox.create();
    store = objectBox.store;
    box = Box<AssetEntity>(store);
  }

  storeAsset(
      {required String assetPath,
      required List<double> imageEmbedding,
      List<double>? annotationEmbedding}) {
    final newAsset = AssetEntity(
        content: assetPath,
        embedding: imageEmbedding,
        dateIndexed: DateTime.now());

    if (annotationEmbedding != null) {
      final assetWithAnnotation = AssetEntity(
          content: assetPath,
          embedding: annotationEmbedding,
          dateIndexed: DateTime.now());

      box.put(assetWithAnnotation);
    }
    box.put(newAsset);

    if (kDebugMode) {
      print('Stored succesfully');
    }
  }

  /// function for getting the closest N items to the query embedding.
  ///
  /// Obviously N should never be higher than the total items in storage.
  ///
  /// Items can be annotation => asset location or asset embedding => asset location.
  ///
  /// Duplicates possible(and very likely!) so  deduplication is required.
  ///
  /// In a perfect world, N would be an optional param, with max(storage.items) as the default =)
  List<AssetEntity>? findNClosestAssets(
      {required int N,
      required List<double> queryEmbedding,
      bool deduplicate = true,
      double scoreThreshold = 0.6}) {
    final query = box
        .query(AssetEntity_.embedding.nearestNeighborsF32(queryEmbedding, N))
        .build();

    final results = query.findIdsWithScores();
    query.close();
    final filtered = results
        .where((scored) => scored.score <= scoreThreshold)
        .map((scored) => box.get(scored.id))
        .whereType<AssetEntity>()
        .toList();

    return deduplicate ? deduplicateAssets(assets: filtered) : filtered;
  }

  List<AssetEntity> get assetsInStorage =>
      deduplicateAssets(assets: box.getAll());

  deletAllAssets() {
    box.removeAll();
  }

  deleteAsset({required List<int> assetIDs}) {
    box.removeMany(assetIDs);
  }

  /// cycle through assets in storage and delete embeddings if the associated file (asset.content) / file Path no longer exists
  prune() {
    final allAssets = box.getAll();

    if (allAssets.isNotEmpty) {
      List<int> assetsToNuke = [];
      for (final AssetEntity asset in allAssets) {
        if (!File(asset.content).existsSync()) {
          assetsToNuke.add(asset.id);
        }
      }

      deleteAsset(assetIDs: assetsToNuke);
    } else {
      return 0;
    }
  }
}
