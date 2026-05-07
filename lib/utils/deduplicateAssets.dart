import 'package:gifza/models/asset_entity.dart';

List<AssetEntity> deduplicateAssets({required List<AssetEntity> results}) {
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
