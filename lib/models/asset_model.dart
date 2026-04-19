import 'dart:typed_data';

class AssetModel {
  final String assetPath;
  final String fileName;
  final Uint8List assetBytes;
  String? assetAnnotation;

  AssetModel(
      {required this.assetPath,
      required this.fileName,
      required this.assetBytes,
      this.assetAnnotation});
}
