import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_wallpapers/model/wallpaper.dart';
import 'package:wallpaperplugin/wallpaperplugin.dart';
import 'package:flutter/services.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';

class ImageView extends StatefulWidget {
  final Wallpaper wallpaper;
  ImageView({@required this.wallpaper});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool permission = false;
  bool downloadImage = false;
  String downloadPer = "0%";
  final String nAvail = "Not Available";

  _permissionRequest() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'TheWallpaper',
    );
    var result = await permissionValidator.storage();
    if (result) {
      setState(() {
        permission = true;
        setWallpaper();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Hero(
          tag: widget.wallpaper.portrait,
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                widget.wallpaper.portrait,
                fit: BoxFit.cover,
              )),
        ),
        Positioned(
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
              alignment: Alignment.bottomRight,
              child: downloadImage
                  ? Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Downloading.. $downloadPer",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        if (permission == false) {
                          print("Requesting Permission");
                          _permissionRequest();
                        } else {
                          print("Permission Granted.");
                          setWallpaper();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text('Set Wallpaper'),
                                SizedBox(width: 5),
                                Icon(Icons.wallpaper),
                              ],
                            )),
                      ),
                    )),
        ),
      ]),
    );
  }

  void setWallpaper() async {
    final dir = await getExternalStorageDirectory();
    print(dir);
    Dio dio = new Dio();
    dio.download(
      widget.wallpaper.original,
      "${dir.path}/thewallpaper.png",
      onReceiveProgress: (received, total) {
        if (total != -1) {
          String downloadingPer =
              ((received / total * 100).toStringAsFixed(0) + "%");
          setState(() {
            downloadPer = downloadingPer;
          });
        }
        setState(() {
          downloadImage = true;
        });
      },
    ).whenComplete(() {
      setState(() {
        downloadImage = false;
      });
      initPlatformState("${dir.path}/thewallpaper.png");
    });
  }

  Future<void> initPlatformState(String path) async {
    // ignore: unused_local_variable
    String wallpaperStatus = "Unexpected Result";
    String _localFile = path;
    try {
      Wallpaperplugin.setWallpaperWithCrop(localFile: _localFile);
      wallpaperStatus = "Wallpaper set";
    } on PlatformException {
      print("Platform exception");
      wallpaperStatus = "Platform Error Occured";
    }
    if (!mounted) return;
  }
}