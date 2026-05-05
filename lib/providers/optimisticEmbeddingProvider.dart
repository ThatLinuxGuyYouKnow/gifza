import 'package:flutter/material.dart';

class EmbeddingProvider extends ChangeNotifier {
  bool _embeddingStatus = true;
  bool get embeddingStatus => _embeddingStatus;

  setOptimisticStatus({required bool status}) {
    _embeddingStatus = false;
  }
}
