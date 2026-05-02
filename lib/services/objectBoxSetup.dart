import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../objectbox.g.dart'; // created by `flutter pub run build_runner build`

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    final store =
        await openStore(directory: p.join(docsDir.path, "gifza-vector-db"));
    return ObjectBox._create(store);
  }
}
