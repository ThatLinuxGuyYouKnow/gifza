import 'dart:typed_data';

enum AssetType { image, gif }

class AssetModel {
  final String assetPath;
  final String fileName;
  final Uint8List assetBytes;
  String? assetAnnotation;
  AssetType? assetType;

  AssetModel(
      {required this.assetPath,
      required this.fileName,
      required this.assetBytes,
      this.assetAnnotation,
      this.assetType = AssetType.image});
}
