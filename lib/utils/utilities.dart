import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
    return images;
  } catch (e) {
    throw e.toString();
  }
}

formatPrice(double price) => 'INR. ${price.toStringAsFixed(2)}';
