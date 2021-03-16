import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_wallpapers/data/data.dart';
import 'package:the_wallpapers/model/pictures_model.dart';
import 'package:the_wallpapers/model/varieties_model.dart';
import 'package:the_wallpapers/views/search_view.dart';
import 'package:the_wallpapers/views/settings.dart';
// import 'package:the_wallpapers/views/settings.dart';
import 'package:the_wallpapers/views/varirties_screen.dart';
import 'package:the_wallpapers/widgets/titlewidget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: deprecated_member_use
  List<VarietiesModel> varieties = new List();
  // ignore: deprecated_member_use

  int noOfImageToLoad = 30;
  bool isLoading = true;
  final bool darkThemeEnabled = false;

  // ignore: deprecated_member_use
  List<PicturesModel> photos = new List();

  getTrendingWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PicturesModel picturesModel = new PicturesModel();
        picturesModel = PicturesModel.fromMap(element);
        photos.add(picturesModel);
      });

      setState(() {});
    });
  }

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    varieties = getVarieties();
    // ignore: unused_local_variable
    var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
    // ignore: unused_local_variable
    double gap = 10;
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();
      }
    });
  }

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
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Setting()));
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                // child: Row(
                //   children: <Widget>[
                //     Expanded(
                //         child: TextField(
                //       controller: searchController,
                //       decoration: InputDecoration(
                //           hintText: "search wallpapers",
                //           border: InputBorder.none),
                //     )),
                //     InkWell(
                //         onTap: () {
                //           if (searchController.text != "") {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => SearchView(
                //                           search: searchController.text,
                //                         )));
                //           }
                //         },
                //         child: Container(child: Icon(Icons.search)))
                //   ],
                // ),
              ),

              // SizedBox(
              //   height: 16,
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              Container(
                height: 10,
                // child: ListView.builder(
                //     padding: EdgeInsets.symmetric(horizontal: 24),
                //     itemCount: varieties.length,
                //     shrinkWrap: true,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (context, index) {
                //       /// Create List Item tile
                //       return VarietiesTile(
                //         // imgUrls: varieties[index].imgUrl,
                //         varietie: varieties[index].varietieName, imgUrls: '',
                //       );
                //     }),
              ),

              wallPaper(photos, context),
              SizedBox(
                height: 24,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Pictures Powered By ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://www.pexels.com/");
                    },
                    child: Container(
                        child: Text(
                      "Pexels",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "By ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://github.com/4eug");
                    },
                    child: Text(
                      "4eug",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       ListTile(
      //         title: Text("Dark Theme"),
      //         trailing: Switch(
      //           value: darkThemeEnabled,
      //           onChanged: bloc.changeTheme,
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          // if (searchController.text != "")
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchView(
                        search: searchController.text,
                      )));
        },
        child: Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
    );
  }
}

// class Bloc {
//   // ignore: close_sinks
//   final _themeController = StreamController<bool>();
//   get changeTheme => _themeController.sink.add;
//   get darkThemeEnabled => _themeController.stream;
// }

// final bloc = Bloc();

class VarietiesTile extends StatelessWidget {
  final String imgUrls, varietie;

  VarietiesTile({@required this.imgUrls, @required this.varietie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VarietieScreen(
                      varietie: varietie,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 30,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 30,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                  SizedBox(
                    height: 4,
                  ),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 30,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 30,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        varietie ?? "See",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}
