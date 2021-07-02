import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_wallpapers/bloc/wallpaperBloc.dart';
import 'package:the_wallpapers/bloc/wallpaperEvent.dart';
import 'package:the_wallpapers/views/TrendingImages.dart';
import 'package:the_wallpapers/views/Search.dart';
import 'package:the_wallpapers/views/Setting.dart';
import 'package:the_wallpapers/widgets/title.dart';

class Homepage extends StatefulWidget {
  final String title;
  Homepage(this.title);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  WallpaperBloc _wallpaperBloc;

  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _wallpaperBloc = BlocProvider.of<WallpaperBloc>(context);
    _wallpaperBloc.add(GetAllWallpaper());
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: brandName(),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => Setting()));
            },
          )
        ],
      ),
      body: TrendingImages(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.search,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Search()));
        },
        elevation: 3.0,
      ),
    );
  }
}
