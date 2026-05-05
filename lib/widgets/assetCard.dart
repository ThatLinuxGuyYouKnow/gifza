import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';

class AssetCard extends StatelessWidget {
  final AssetEntity asset;
  AssetCard({super.key, required this.asset});
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      height: 40,
      width: 80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          decoration: BoxDecoration(
            color: theme.primary,
          ),
          child: Stack(children: [
            Positioned.fill(
              child: Image.file(
                File(asset.content),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 15,
                right: 15,
                child: GestureDetector(
                  onTap: () => null,
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
      ),
    );
  }
}
