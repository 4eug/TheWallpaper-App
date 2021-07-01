import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:the_wallpapers/data/data.dart';
// import 'package:the_wallpapers/home.dart';
// import 'package:the_wallpapers/home.dart';
import 'package:the_wallpapers/model/pictures_model.dart';
import 'package:the_wallpapers/model/varieties_model.dart';
import 'package:the_wallpapers/widgets/titlewidget.dart';

class SearchView extends StatefulWidget {
  final String search;

  SearchView({@required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  // ignore: deprecated_member_use
  List<PicturesModel> photos = new List();
  // ignore: deprecated_member_use
  List<VarietiesModel> varieties = new List();

  bool isLoading = true;
  TextEditingController searchController = new TextEditingController();

  Future getSearchWallpaper(String searchQuery) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    try {
      await ioClient.get(
          "https://api.pexels.com/v1/search?query=$searchQuery&per_page=100&page=1",
          headers: {"Authorization": apiKEY}).then((value) {
        print(value.body);

        Map<String, dynamic> jsonData = jsonDecode(value.body);
        jsonData["photos"].forEach((element) {
          PicturesModel picturesModel = new PicturesModel();
          picturesModel = PicturesModel.fromMap(element);
          photos.add(picturesModel);
          //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
        });
      });
    } catch (e) {
      print(e.toString());
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    try {
      getSearchWallpaper(widget.search);
    } catch (err) {
      print(err);
    }

    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: () {
                        if (searchController.text != "") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchView(
                                        search: searchController.text,
                                      )));
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "search wallpapers",
                          border: InputBorder.none),
                    )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchView(
                                          search: searchController.text,
                                        )));
                          }
                        },
                        child: Container(child: Icon(LineAwesomeIcons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Column(
                children: [
                  isLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.black,
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                        )
                      : wallPaper(photos, context),
                ],
              )),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   height: 1000,
              //   child: GridView.builder(
              //       padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              //       gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2),
              //       itemCount: varieties.length,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return VarietiesTile(
              //           imgUrls: varieties[index].imgUrl,
              //           varietie: varieties[index].varietieName,
              //         );
              //       }),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
