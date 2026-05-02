import 'package:gifza/models/asset_entity.dart';
import 'package:gifza/services/objectBoxSetup.dart';
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
    );

    if (annotationEmbedding != null) {
      final assetWithAnnotation =
          AssetEntity(content: assetPath, embedding: annotationEmbedding);

      box.put(assetWithAnnotation);
    }
    box.put(newAsset);
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
    _deduplicate(results) {
      final seenAssets =
          <String>{}; //strongly typed string set, fucntionally could also be a list, but Set has O(1) look up so preferred
      final assetsToReturn = <AssetEntity>[];

      for (AssetEntity asset in results) {
        if (!seenAssets.contains(asset.content)) {
          assetsToReturn.add(asset);
          seenAssets.add(asset.content);
        }
      }

      return assetsToReturn;
    }

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

    return deduplicate ? _deduplicate(filtered) : filtered;
  }
}
