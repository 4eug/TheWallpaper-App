import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'varirties_screen.dart';

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
