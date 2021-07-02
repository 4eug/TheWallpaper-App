import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:the_wallpapers/const.dart';
import 'package:the_wallpapers/widgets/developers_info.dart';
import 'package:the_wallpapers/widgets/listtile.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String _packageName;
  String version;

  get url => null;
  @override
  void initState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      _packageName = packageInfo.packageName;
      version = packageInfo.version;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: <Widget>[
          aboutListTile(
            title: 'Rate this app',
            subtitle: 'If you love it and you know it give it 5 stars',
            icon: LineAwesomeIcons.star,
            onTap: () => launch(url + _packageName),
          ),
          aboutListTile(
            title: 'Share this app',
            subtitle: 'Don\'t have all the fun alone',
            icon: LineAwesomeIcons.share,
            onTap: () {
              Share.share(
                "$message\n${url + _packageName}",
              );
            },
          ),
          aboutListTile(
            title: 'Report a bug',
            subtitle: 'A bug reported is a bug squashed',
            icon: LineAwesomeIcons.bug,
            onTap: () => launch(
                'mailto:debraheug@gmail.com?subject=TheWallpaper%20Bug%20Report&body='),
          ),
          aboutListTile(
            title: 'Developer Info',
            subtitle: 'Find out who is behind this app',
            icon: LineAwesomeIcons.code,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => DevelopersInfo());
            },
          ),
        ],
      ),
    );
  }
}
