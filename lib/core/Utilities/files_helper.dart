
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../API/api.dart';


class FilesHelper{
  static String getFileSize(File? file){
    if(file == null) return "0";
    return (file.lengthSync()/1024).toStringAsFixed(2);
  }
  static String getFileName(File? file){
    if(file == null) return "-";
    return file.path.split("/").last.split("").reversed.take(15).toList().reversed.join();
  }

  static Future<String> getFolderPath()async{
    String folderName = "MeleCRM";
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    final Directory newDirectory = Directory('$appDocumentsPath/$folderName/');
    return (await newDirectory.create(recursive: true)).path;
  }

  static Future<File?> getAndDownloadEquitableFile({String? fileName,String? filePath,bool canDownload = true})async{
    if(fileName == null) return null;
    String folderPath = await getFolderPath();
    final allFiles = Directory(folderPath).listSync();
    for (FileSystemEntity file in allFiles) {
      if(file.path.contains(fileName)) return File(file.path);
    }
    if(!canDownload) return null;

    Uint8List? downloadedData = await API.getDataFromUrl(url: filePath);
    if(downloadedData == null) return null;
    return File("$folderPath$fileName")..writeAsBytesSync(downloadedData);
  }

  static Future getOnlineFileSize(String? url)async{
    if(url == null) return null;
    http.Response r = await http.head(Uri.parse(url));
    return r.headers["content-length"];
  }

}