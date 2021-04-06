import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:the_wallpapers/const.dart';
import 'package:the_wallpapers/widgets/adaptiveness.dart';
import 'package:the_wallpapers/widgets/listtilewidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';

class DevelopersInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // throw 'Could not launch $url';
        Toast.show(
          'Couldn\'t open $url\nPlease try again later',
          context,
          duration: 2,
          backgroundColor: brightnessAwareColor(context,
              lightColor: Colors.black87, darkColor: Colors.white70),
          textColor: brightnessAwareColor(context,
              lightColor: Colors.white, darkColor: Colors.black),
          backgroundRadius: 10.0,
          gravity: 0,
        );
      }
    }

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: brightnessAwareColor(context,
            lightColor: Color(0xFF757575), darkColor: Colors.black),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Adaptiveness(
        title: 'Developer Info',
        hasSelectButton: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 140.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/4euglogo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Eugene Debrah',
                    style: TextStyle(
                      fontFamily: 'Righteous',
                      fontSize: 22.0,
                    ),
                  ),
                  Text('4eug', style: titleTextStyle),
                  SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: brightnessAwareColor(context,
                          lightColor: Colors.grey[100],
                          darkColor: Colors.black26),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        aboutListTile(
                          title: 'Github',
                          icon: LineAwesomeIcons.github,
                          onTap: () => launchURL('https://github.com/4eug'),
                        ),
                        aboutListTile(
                          title: 'Twitter',
                          icon: LineAwesomeIcons.twitter,
                          onTap: () => launchURL('https://twitter.com/4eug_'),
                        ),
                        aboutListTile(
                          title: 'Instagram',
                          icon: LineAwesomeIcons.instagram,
                          onTap: () =>
                              launchURL('https://www.instagram.com/_.4eug/'),
                        ),
                        aboutListTile(
                          title: 'LinkedIn',
                          icon: LineAwesomeIcons.linkedin,
                          onTap: () => launchURL(
                              'https://www.linkedin.com/in/eugene-debrah/'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListTile infoListTile(BuildContext context,
      {IconData icon, String title, Function onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: brightnessAwareColor(context,
            lightColor: Colors.black, darkColor: Colors.white),
      ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: titleTextStyle.copyWith(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: onTap,
    );
  }
}
