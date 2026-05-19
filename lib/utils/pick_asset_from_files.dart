import 'package:file_picker/file_picker.dart';

pickAsset() async {
  FilePickerResult? filePickerResult = await FilePicker.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['gif', 'jpg', 'jpeg', 'png', 'webp']);

  return filePickerResult;
}
