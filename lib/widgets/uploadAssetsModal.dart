import 'package:flutter/material.dart';
import 'package:gifza/providers/assetProvider.dart';
import 'package:gifza/utils/pickAssetfromFiles.dart';
import 'package:provider/provider.dart';

class UploadAssetModal extends StatelessWidget {
  const UploadAssetModal({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final assetProvider = Provider.of<AssetProvider>(context, listen: true);

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
            Container(
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
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.6),
                              hoverColor: Colors.red.withOpacity(0.8),
                            ),
                            onPressed: () {
                              assetProvider.clear();
                            },
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final picked = await pickAsset();
                            if (picked != null) {
                              assetProvider.loadInAsset(File: picked);
                            }
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
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
              child: const Center(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: 'E.g Pic of me with Gandhi',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 80,
              width: 700,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: scheme.primary),
              child: const Center(
                child: Text('Index',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
