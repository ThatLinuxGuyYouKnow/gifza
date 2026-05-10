import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gifza/providers/assetProvider.dart';
import 'package:gifza/services/embeddingService.dart';
import 'package:gifza/services/objectBoxService.dart';

import 'package:gifza/services/tokenizerService.dart';
import 'package:gifza/utils/pickAssetfromFiles.dart';
import 'package:gifza/utils/preprocessImage.dart';
import 'package:gifza/widgets/alerts/errorAlert.dart';

import 'package:gifza/widgets/alerts/sucessfulIndex.dart';
import 'package:provider/provider.dart';

class UploadAssetModal extends StatefulWidget {
  const UploadAssetModal({super.key});

  @override
  State<UploadAssetModal> createState() => _UploadAssetModalState();
}

class _UploadAssetModalState extends State<UploadAssetModal> {
  String? annotationText;
  bool _isIndexing = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final assetProvider = Provider.of<AssetProvider>(context, listen: true);
    final tokenizer = context.read<ClipTokenizerService>();
    final embedding = context.read<EmbeddingService>();
    final objectBox = context.read<ObjectBoxService>();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 650,
        width: 600,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        decoration: BoxDecoration(
            color: const Color(0xFF1A2744),
            borderRadius: BorderRadius.circular(40)),
        child: Column(
          children: [
            const Text(
              'Index New Assets',
              style: TextStyle(
                  fontFamily: 'Jakarta',
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            const SizedBox(height: 5),
            const Text(
              'Add new images or GIF\'s to your vault',
              style: TextStyle(
                  fontFamily: 'Vietnam', fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            /// === BOX FOR UPLOADING ASSETS ===
            GestureDetector(
              onTap: (assetProvider.asset == null)
                  ? () async {
                      final picked = await pickAsset();
                      if (picked != null) {
                        assetProvider.loadInAsset(File: picked);
                      }
                    }
                  : null,
              child: Container(
                height: 250,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: const Color(0xFF141f38),
                    borderRadius: BorderRadius.circular(30)),
                child: assetProvider.asset != null
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(
                            assetProvider.asset!.assetBytes,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              top: 15,
                              right: 15,
                              child: GestureDetector(
                                onTap: () => assetProvider.clear(),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.delete),
                                ),
                              )),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: scheme.primary.withOpacity(0.1)),
                            child: Icon(
                              Icons.upload,
                              color: scheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Drag and Drop new assets',
                            style: TextStyle(
                                fontFamily: 'Vietnam',
                                fontSize: 12,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'or click to pick an image from your gallery',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          )
                        ],
                      ),
              ),
            ),

            /// === BOX STOPS HERE ===

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF141f38),
              ),
              height: 80,
              width: 700,
              child: Center(
                child: TextField(
                  onChanged: (text) => setState(() {
                    annotationText = text;
                  }),
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: 'E.g Pic of me with Gandhi',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: (_isIndexing == true || assetProvider.asset == null)
                  ? null
                  : () async {
                      setState(() {
                        _isIndexing = true;
                      });

                      final imagePipeline = () async {
                        if (kDebugMode) {
                          print('starting image embedding');
                        }
                        try {
                          final imageTensorFuture = compute(
                              preprocessImage, assetProvider.asset!.assetBytes);

                          final result = await embedding.generateEmbeddings(
                              assetType: AssetType.image,
                              imageTensor: await imageTensorFuture);

                          if (kDebugMode) {
                            print('all done with image embedding!');
                          }
                          return result;
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ErrorAlert(
                                  errorTitle: 'Error Occured $e',
                                );
                              });
                        }
                      }();

                      final textPipeline = (annotationText != null)
                          ? () async {
                              if (kDebugMode) {
                                print('starting text embedding');
                              }

                              final tokens =
                                  tokenizer.tokenize(annotationText ?? '');
                              if (kDebugMode) {
                                print('finished tokenizing');
                              }
                              final result = await embedding.generateEmbeddings(
                                  tokens: tokens, assetType: AssetType.text);

                              if (kDebugMode) {
                                print('all done with image embedding!');
                              }

                              return result;
                            }()
                          : null;

                      final textEmbeddings = await textPipeline;
                      final imageEmbeddings = await imagePipeline;
                      if (annotationText != null) {
                        objectBox.storeAsset(
                            assetPath: assetProvider.asset!.assetPath,
                            imageEmbedding: imageEmbeddings!,
                            annotationEmbedding: textEmbeddings);
                      } else {
                        objectBox.storeAsset(
                          assetPath: assetProvider.asset!.assetPath,
                          imageEmbedding: imageEmbeddings!,
                        );
                      }
                      setState(() {
                        _isIndexing = false;
                      });

                      assetProvider.clear();
                      Navigator.pop(context);

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SuccesfulIndexAlert(
                              annotation: annotationText,
                            );
                          });
                    },
              child: Container(
                height: 80,
                width: 700,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: scheme.primary),
                child: Center(
                  child: _isIndexing
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text('Index',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
