import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfApi {
  Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    Directory? directory;
    final bytes = await pdf.save();
    // final dir = await getExternalStorageDirectory();
    directory = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/$folder";
      } else {
        break;
      }
    }
    newPath = "$newPath/CityMedicalApp";
    directory = Directory(newPath);
    final file = File('${directory.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  //
  static Future<File> saveVideo(
      {required String name, required Document pdf}) async {
    Directory? directory;
    File? fl;
    final bytes = await pdf.save();
    try {
      if (await _hasAcceptedPermissions()) {
        directory = await getExternalStorageDirectory();
        String newPath = "";
        print(directory);
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/$folder";
          } else {
            break;
          }
        }
        newPath = "$newPath/CityMedicalApp";
        directory = Directory(newPath);
      } else {}

      if (!await directory!.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        log(directory.toString());
        fl = File('${directory.path}/$name');
        await fl.writeAsBytes(bytes);

        return fl;

        // if (Platform.isIOS) {
        //   await ImageGallerySaver.saveFile(saveFile.path,
        //       isReturnPathOfIOS: true);
        // }
        // return true;
      }
    } catch (e) {
      print(e);
    }
    return fl!;
  }

  static Future openFile(File file) async {
    final url = file.path;
    log(url);
    await OpenFilex.open(url);
  }

  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> _hasAcceptedPermissions() async {
    if (Platform.isAndroid) {
      if (await _requestPermission(Permission.storage) &&
          // access media location needed for android 10/Q
          await _requestPermission(Permission.accessMediaLocation) &&
          // manage external storage needed for android 11/R
          await _requestPermission(Permission.manageExternalStorage)) {
        return true;
      } else {
        return false;
      }
    }
    if (Platform.isIOS) {
      if (await _requestPermission(Permission.photos)) {
        return true;
      } else {
        return false;
      }
    } else {
      // not android or ios
      return false;
    }
  }
}
