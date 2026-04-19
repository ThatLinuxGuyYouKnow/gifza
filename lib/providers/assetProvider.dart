import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gifza/models/asset_model.dart';

class AssetProvider extends ChangeNotifier {
  AssetModel? _asset;

  AssetModel? get asset => _asset;

  loadInAsset({required FilePickerResult File}) {
    final file = File.files.single;

    _asset = AssetModel(
        assetPath: file.path!, fileName: file.name, assetBytes: file.bytes!);

    notifyListeners();
  }

  setAnnotation({required String annotation}) {
    _asset?.assetAnnotation = annotation;

    notifyListeners();
  }

  clear() {
    _asset = null;
    notifyListeners();
  }
}
