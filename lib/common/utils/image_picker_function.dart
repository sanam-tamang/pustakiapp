import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final file = File(pickedFile.path);
    return file;
  } else {
    return null;
  }
}
