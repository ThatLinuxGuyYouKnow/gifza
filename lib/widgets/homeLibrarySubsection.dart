import 'package:flutter/material.dart';
import 'package:gifza/models/asset_entity.dart';
import 'package:gifza/services/objectBoxService.dart';
import 'package:gifza/widgets/assetCard.dart';
import 'package:gifza/widgets/customPainter.dart';
import 'package:provider/provider.dart';

class HomeLibrarySubsection extends StatelessWidget {
  const HomeLibrarySubsection({super.key});

  Widget build(BuildContext context) {
    final _objectBox = context.read<ObjectBoxService>();

    // only display 4(max) at a time, we don't want to render too many images here, users can view all their images in their Library
    List<AssetEntity> _assets = _objectBox.assetsInStorage
        .asMap()
        .entries
        .where((entry) => entry.key % 4 == 0)
        .map((entry) => entry.value)
        .toList();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 80),
      child: _assets.isEmpty
          ? EmptyAssetState()
          : GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                final asset = _assets[index];
                return AssetCard(
                  asset: asset,
                );
              },
              itemCount: _assets.length,
            ),
    );
  }
}

class EmptyAssetState extends StatelessWidget {
  const EmptyAssetState({super.key});

  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return CustomPaint(
      painter: DashedBorderPainter(color: theme.primary),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 80.0, horizontal: 20),
          child: Text(
            'No assets in your vault',
            style: TextStyle(fontFamily: 'Jakarta', fontSize: 18),
          ),
        )),
      ),
    );
  }
}
