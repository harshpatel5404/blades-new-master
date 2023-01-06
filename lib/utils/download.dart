import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> createFolder() async {
  Directory tempDir = await getTemporaryDirectory();
  String temppath = "${tempDir.path}/rnappz";
  final path = Directory(temppath);
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await path.exists())) {
    return path.path;
  } else {
    path.create();
    return path.path;
  }
}

Future<String> savegalleryFile(url) async {
  var extenssion = url.split('.').last;
  var filename = DateTime.now().millisecondsSinceEpoch.toString();
  var savePath = await createFolder();
  print(savePath);
  savePath = "$savePath/$filename.$extenssion";
  await Dio().download(
      "https://nodeserver.mydevfactory.com:3309/channelContent/$url", savePath);
  final result = await ImageGallerySaver.saveFile(savePath);
  return savePath;
}

Future saveimgpath(url) async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  var extenssion = url.split('.').last;
  var filename = DateTime.now().millisecondsSinceEpoch.toString();
  Directory dir = await getTemporaryDirectory();
  var sharePath = "${dir.path}/$filename.$extenssion";
  await Dio().download(
      "https://nodeserver.mydevfactory.com:3309/channelContent/$url",
      sharePath);

  return sharePath;
}
