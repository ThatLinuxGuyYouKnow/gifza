import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';

class AssetInfoModal extends StatelessWidget {
  final AssetEntity asset;
  const AssetInfoModal({super.key, required this.asset});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final bool fileExists = File(asset.content).existsSync();
    return AlertDialog(
      backgroundColor: theme.surface,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Asset Info',
            style: TextStyle(
                fontFamily: 'Jakarta',
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Asset path',
                style: TextStyle(
                  fontFamily: 'Jakarta',
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 10, 18, 34),
                  ),
                  child: Padding(
                      padding: EdgeInsetsGeometry.all(8.0),
                      child: Text(
                        asset.content,
                        style: TextStyle(
                            color: fileExists ? Colors.white : Colors.red),
                      )))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Added on :',
                style: TextStyle(
                  fontFamily: 'Jakarta',
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text((asset.dateIndexed == DateTime.fromMillisecondsSinceEpoch(0))
                  ? 'N / A'
                  : asset.dateIndexed.toString()),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          fileExists
              ? SizedBox.shrink()
              : Row(
                  children: [
                    Icon(Icons.broken_image),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Asset has been deleted or moved from its path')
                  ],
                )
        ],
      ),
    );
  }
}
