import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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

showMessage({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 400),
      behavior: SnackBarBehavior.floating,
      width: MediaQuery.of(context).size.width * 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: const Color.fromARGB(255, 151, 151, 151),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      )));
}

formatPrice(double price) => 'INR. ${price.toStringAsFixed(2)}';
