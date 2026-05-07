import 'package:gifza/models/asset_entity.dart';

sortAssets({required List<AssetEntity> assets, String? sortOrder = 'desc'}) {
  final List<AssetEntity> allSavedAssets = assets.toList();

  allSavedAssets.sort(
    (a, b) {
      final dateA = a.dateIndexed;
      final dateB = b.dateIndexed;

      if (sortOrder == 'desc') {
        return dateB!.compareTo(dateA!);
      } else {
        return dateA!.compareTo(dateB!);
      }
    },
  );

  return allSavedAssets;
}
