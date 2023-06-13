import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> customFilePicker() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    File? file = File(result.files.single.path!);
    return file;
    // Use the file variable to upload the file to the server.
  } else {
    return null;
  }
}
