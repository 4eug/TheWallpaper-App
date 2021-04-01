import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

import '../data/data.dart';
import '../model/pictures_model.dart';
// import '../model/varieties_model.dart';

Future getTrendingWallpaper(noOfImageToLoad) async {
  // ignore: deprecated_member_use
  List<PicturesModel> photos = new List();

  bool trustSelfSigned = true;
  HttpClient httpClient = new HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);
  try {
    await ioClient.get(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1/",
        headers: {"Authorization": apiKEY}).then((value) {
      print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PicturesModel picturesModel = new PicturesModel();
        picturesModel = PicturesModel.fromMap(element);
        photos.add(picturesModel);
      });
    });
  } catch (e) {
    print(e.toString());
  }
  return {photos};
}
