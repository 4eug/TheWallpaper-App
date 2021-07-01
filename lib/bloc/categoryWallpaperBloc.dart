import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:the_wallpapers/bloc/wallpaperEvent.dart';
import 'package:the_wallpapers/bloc/wallpaperState.dart';
import 'package:the_wallpapers/model/wallpaper.dart';

class CategoryWallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  // ignore: deprecated_member_use
  List<Wallpaper> _categoryWallpaper = List<Wallpaper>();
  @override
  WallpaperState get initialState => CategoryWallpaperIsLoading();

  @override
  Stream<WallpaperState> mapEventToState(WallpaperEvent event) async* {
    if (event is CategoryWallpaper) {
      yield CategoryWallpaperIsLoading();
      try {
        var response = await http.get(
            Uri.encodeFull(searchEndPoint + event.category + perPageLimit),
            headers: {
              "Accept": "application/json",
              "Authorization": "$apiKey"
            });
        var data = jsonDecode(response.body)["photos"];
        // ignore: deprecated_member_use
        _categoryWallpaper = List<Wallpaper>();
        for (var i = 0; i < data.length; i++) {
          _categoryWallpaper.add(Wallpaper.fromMap(data[i]));
        }
        yield CategoryWallpaperIsLoaded(_categoryWallpaper);
      } catch (_) {
        yield CategoryWallpaperIsNotLoaded();
      }
    }
  }
}
