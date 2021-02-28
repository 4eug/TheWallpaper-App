import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_wallpapers/data/data.dart';
import 'package:the_wallpapers/model/pictures_model.dart';
import 'package:the_wallpapers/widgets/titlewidget.dart';

class VarietieScreen extends StatefulWidget {
  final String varietie;

  VarietieScreen({@required this.varietie});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<VarietieScreen> {
  // ignore: deprecated_member_use
  List<PicturesModel> pictures = new List();

  getCategorieWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/search?query=${widget.varietie}&per_page=30&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PicturesModel picturesModel = new PicturesModel();
        picturesModel = PicturesModel.fromMap(element);
        pictures.add(picturesModel);
        // print(picturesModel.toString() + "  " + picturesModel.src.portrait);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
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
      body: SingleChildScrollView(
        child: wallPaper(pictures, context),
      ),
    );
  }
}
