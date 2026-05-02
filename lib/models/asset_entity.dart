import 'package:objectbox/objectbox.dart';

@Entity()
class AssetEntity {
  @Id()
  int id;

  // The raw content: A file path (for images) or the actual string (for text)
  String content;

  // MobileCLIP-S1 uses exactly 512 dimensions.
  @HnswIndex(dimensions: 512)
  @Property(type: PropertyType.floatVector)
  List<double>? embedding;

  AssetEntity({
    this.id = 0,
    required this.content,
    this.embedding,
  });
}
