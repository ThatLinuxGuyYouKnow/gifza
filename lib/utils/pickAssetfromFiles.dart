import 'package:file_picker/file_picker.dart';

pickAsset() async {
  FilePickerResult? filePickerResult =
      await FilePicker.pickFiles(withData: true);

  return filePickerResult;
}
