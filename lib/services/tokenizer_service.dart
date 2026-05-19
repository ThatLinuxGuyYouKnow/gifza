import 'package:flutter/services.dart';
import 'package:dart_sentencepiece_tokenizer/dart_sentencepiece_tokenizer.dart';

class ClipTokenizerService {
  late SentencePieceTokenizer _tokenizer;

  static const int startToken = 49406;
  static const int endToken = 49407;
  static const int padToken = 0;
  static const int maxLength = 77;

  Future<void> init() async {
    final jsonString =
        await rootBundle.loadString('assets/models/tokenizer.json');

    _tokenizer = TokenizerJsonLoader.fromJsonString(jsonString);
  }

  List<int> tokenize(String text) {
    final encoded = _tokenizer.encode(text);

    List<int> rawTokens = encoded.ids.toList();

    if (rawTokens.length > maxLength - 2) {
      rawTokens = rawTokens.sublist(0, maxLength - 2);
    }

    List<int> finalTokens = [
      startToken,
      ...rawTokens,
      endToken,
    ];

    while (finalTokens.length < maxLength) {
      finalTokens.add(padToken);
    }

    return finalTokens;
  }
}
