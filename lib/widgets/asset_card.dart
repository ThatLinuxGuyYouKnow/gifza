import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';
import 'package:gifza/widgets/asset_info_modal.dart';

class AssetCard extends StatelessWidget {
  final AssetEntity asset;
  const AssetCard({super.key, required this.asset});
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        decoration: BoxDecoration(
          color: theme.primary,
        ),
        child: Stack(children: [
          Positioned.fill(
              child: File(asset.content).existsSync()
                  ? Image.file(
                      File(asset.content),
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.broken_image)),
          Positioned(
              top: 15,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AssetInfoModal(asset: asset);
                      });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.menu),
                ),
              )),
        ]),
      ),
    );
  }
}
