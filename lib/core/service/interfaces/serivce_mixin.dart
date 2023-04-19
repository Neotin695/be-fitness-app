import 'dart:io';

import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

mixin PickMedia {
  final ImagePicker _imagePicker = ImagePicker();

  Future<String> pickSingleImage(ImageSource imageSource) async {
    try {
      final file = await _imagePicker.pickImage(source: ImageSource.camera);
      if (file == null) {
        return '';
      } else {
        return file.path;
      }
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<List<String>> pickMultiImages(ImageSource imageSource) async {
    return [];
  }

  Future<String> retrieveLostData() async {
    final response = await _imagePicker.retrieveLostData();
    if (response.isEmpty) {
      return '';
    }
    if (response.file != null) {
      return response.file!.path;
    } else {
      return '';
    }
  }

  Future<String> pickDocument(
      BuildContext context, ScannerFileSource fileSource) async {
    try {
      File? scanResult = await DocumentScannerFlutter.launch(
        context,
        source: fileSource,
      );
      if (scanResult == null) {
        throw 'scan result is empty';
      } else {
        return scanResult.path;
      }
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<List<String>> uploadMultiFiles(
      List<String> files, Reference reference) async {
    List<String> tempDownloadUrl = [];
    for (var path in files) {
      final task =
          await reference.child(path.split('/').last).putFile(File(path));
      if (task.state == TaskState.success) {
        tempDownloadUrl.add(await task.ref.getDownloadURL());
      } else if (task.state == TaskState.error) {
        tempDownloadUrl.clear();
        throw 'somthing went wrong';
      }
    }
    return tempDownloadUrl;
  }

  Future<String> uploadSingleFile(String filePath, Reference reference) async {
    final task =
        await reference.child(filePath.split('/').last).putFile(File(filePath));
    if (task.state == TaskState.error) {
      throw 'somthing went wrong';
    }
    return await reference.getDownloadURL();
  }
}
