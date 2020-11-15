import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/widgets/widget.dart';

class Category extends StatefulWidget {

  final String categoryName;
  Category({this.categoryName});
  
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallpaperModel> wallpapers = new List();

  getSearchWallpaper(String query) async {
    var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=15&page=1",
        headers: {
          "Authorization" : apiKey});

    Map<String,dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getSearchWallpaper(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              wallpapersList(wallpapers: wallpapers,context: context),
            ],
          ),
        ),
      ),
    );
  }
}
