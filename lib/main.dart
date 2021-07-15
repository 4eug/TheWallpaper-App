import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:the_wallpapers/bloc/searchWallpaperBloc.dart';
import 'package:the_wallpapers/bloc/wallpaperBloc.dart';
import 'package:the_wallpapers/views/HomePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperBloc(),
      child: BlocProvider(
        create: (context) => SearchWallpaperBloc(),
        child: MaterialApp(
          title: 'TheWallpaper',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.light,
              cardColor: Colors.white38,
              accentColor: Colors.black,
              // ignore: deprecated_member_use
              cursorColor: Colors.black,
              dialogBackgroundColor: Colors.white,
              primaryColor: Colors.white),
          home: Scaffold(
              body: DoubleBackToCloseApp(
                  snackBar: SnackBar(
                    content: Text('Tap back again to leave'),
                  ),
                  child: Homepage('TheWallpaper'))),
        ),
      ),
    );
  }
}
