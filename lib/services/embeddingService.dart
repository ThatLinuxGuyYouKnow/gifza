import 'dart:math';
import 'dart:typed_data';

import 'package:executorch_flutter/executorch_flutter.dart';
import 'package:flutter/services.dart';

enum ObjectType { image, text }

class EmbeddingService {
  ExecuTorchModel? _textModel;
  ExecuTorchModel? _imageModel;

  initialize() async {
    final textByteData = await rootBundle.load('assets/models/text.pte');
    final imageByteData = await rootBundle.load('assets/models/image.pte');

    _textModel =
        await ExecuTorchModel.loadFromBytes(textByteData.buffer.asUint8List());
    _imageModel =
        await ExecuTorchModel.loadFromBytes(imageByteData.buffer.asUint8List());
  }

  Future<List<double>?> generateEmbeddings(
      {List<int>? tokens,
      Float32List? imageTensor,
      required ObjectType objectType}) async {
    if (_textModel == null) {
      throw Exception('Text model failed to initialize, does it exist?');
    }
    if (_imageModel == null) {
      throw Exception('Image model failed to initialize, does it exist?');
    }

    if (objectType == ObjectType.text) {
      final int32tokens = Int32List.fromList(tokens!);

      final inputTensors = TensorData(
          shape: [1, 77],
          dataType: TensorType.int32,
          data: Uint8List.view(int32tokens.buffer, int32tokens.offsetInBytes,
              int32tokens.lengthInBytes));

      try {
        final output = await (_textModel!.forward([inputTensors]));

        if (output.isNotEmpty) {
          final outputTensor = output.first;

          final floatList = Float32List.sublistView(outputTensor.data);

          final rawEmbeddings = floatList.toList();

          return _normalize(rawEmbeddings);
        }
      } catch (error) {
        throw Exception('Failed to generate Embeddings');
      }
    } else {
      final inputTensors = TensorData(
          shape: [1, 3, 256, 256],
          dataType: TensorType.float32,
          data: Uint8List.view(imageTensor!.buffer, imageTensor.offsetInBytes,
              imageTensor.lengthInBytes));

      final imageOutput = await _imageModel!.forward([inputTensors]);
      return _normalize(
          Float32List.sublistView(imageOutput.first.data).toList());
    }
    return null;
  }

  /// L2 normalization
  List<double> _normalize(List<double> vector) {
    double sumSq = 0.0;
    for (var v in vector) {
      sumSq += v * v;
    }
    final magnitude = sqrt(sumSq);
    if (magnitude == 0) return vector; // Prevent divide by zero

    return vector.map((v) => v / magnitude).toList();
  }
}
