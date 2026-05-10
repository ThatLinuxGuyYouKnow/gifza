import 'dart:typed_data';

import 'package:image/image.dart' as img;

extractGIFframes({required Uint8List rawGIFbytes, int maxFrames = 3}) {
  final decodedGIF = img.decodeGif(rawGIFbytes);
  List<Uint8List> framesToReturn = [];

  if (decodedGIF == null) {
    throw Exception('An error occured when processing this GIF');
  }

  final int totalFrames = decodedGIF.numFrames;
//if its a small / short duration gif with total frames less than or equal to our maxFrames, we'll just return and subsequently embed everything
  if (totalFrames <= maxFrames) {
    for (var i = 0; i < maxFrames; i++) {
      final frame = decodedGIF.frames[i];

      framesToReturn.add(img.encodeJpg(frame));
    }
  }
  // else if its longer we'll take exactly max frames worth of equidistant frames
  else {
    for (var i = 0; i < maxFrames; i++) {
      int frameIndex = (i * (totalFrames - 1) / (maxFrames - 1)).round();
      final frame = decodedGIF.frames[frameIndex];

      framesToReturn.add(img.encodeJpg(frame));
    }
  }
}
