import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:the_wallpapers/model/Global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageView extends StatefulWidget {
  final String imgPath;

  ImageView({@required this.imgPath});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

  get dio => null;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgPath,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: kIsWeb
                  ? Image.network(widget.imgPath, fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: widget.imgPath,
                      placeholder: (context, url) => Container(
                        color: Color(0xfff5f8fd),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                    onTap: () async {
                      if (kIsWeb) {
                        _launchURL(widget.imgPath);
                        var js;
                        js.context.callMethod('downloadUrl', [widget.imgPath]);
                        // ignore: unused_local_variable
                        var response =
                            await dio.download(widget.imgPath, "./xx.html");
                        // displayModalBottomSheet(context);
                      } else {
                        _save();
                      }
                      // Navigator.pop(context);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white24, width: 1),
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color(0x0FFFFFFF)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Set Wallpaper",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  kIsWeb
                                      ? "Image will open in new tab to download"
                                      : "Image will be saved in gallery",
                                  style: TextStyle(
                                      fontSize: 8, color: Colors.white70),
                                ),
                              ],
                            )),
                      ],
                    )),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgPath,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      // ignore: unused_local_variable
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.photos]);
    } else {
      /* PermissionStatus permission = */ await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}

void displayModalBottomSheet(context) {
  showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              ListTile(
                  leading: new Icon(Icons.lock),
                  title: new Text('Lock Screen'),
                  onTap: () {
                    setWallpaperLockScreen();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: new Icon(Icons.home),
                title: new Text('Home Screen'),
                onTap: () {
                  setWallpaperHomeScreen();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: new Icon(Icons.done_all_rounded),
                title: new Text('Home & Lock Both'),
                onTap: () {
                  setWallpaperBoth();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
}

Future<void> setWallpaperHomeScreen() async {
  String url = Global.photos[Global.index].src.large;
  int location = WallpaperManager
      .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
  var file = await DefaultCacheManager().getSingleFile(url);
  // ignore: unused_local_variable
  final String result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);
}

Future<void> setWallpaperLockScreen() async {
  String url = Global.photos[Global.index].src.large;
  int location = WallpaperManager
      .LOCK_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
  var file = await DefaultCacheManager().getSingleFile(url);
  // ignore: unused_local_variable
  final String result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);
}

Future<void> setWallpaperBoth() async {
  String url = Global.photos[Global.index].src.large;
  int location = WallpaperManager
      .BOTH_SCREENS; // or location = WallpaperManager.LOCK_SCREEN;
  var file = await DefaultCacheManager().getSingleFile(url);
  // ignore: unused_local_variable
  final String result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);
}
