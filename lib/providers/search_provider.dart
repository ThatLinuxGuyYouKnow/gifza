import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';

class SearchProvider extends ChangeNotifier {
  List<AssetEntity> get assets => _assets;
  List<AssetEntity> _assets = <AssetEntity>[];

  updateSearchResults({required List<AssetEntity> results}) {
    _assets = results;
    notifyListeners();
  }

  clearResults() {
    _assets = [];
    notifyListeners();
  }
}
