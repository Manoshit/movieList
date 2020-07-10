import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:apptunix_task/models/movieModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Movies with ChangeNotifier {
  List<Movie> _movieList = [];

  List<Movie> get moviesListData {
    return _movieList;
  }

  void clearList() {
    _movieList.clear();
    notifyListeners();
  }

  Future<void> fetchMovie() async {
    Dio dio = Dio();
    int min = 100, max = 3000;
    int r = min + Random().nextInt(max - min);
    String val = r.toString();
    final url = 'https://api.themoviedb.org/3/movie/$val';
    try {
      final response = await dio.get(url,
          queryParameters: {'api_key': '85ef2d13cd30e29f4f907e5c27ad7c9c'});
      if (response.statusCode == 200) {
        _movieList.add(Movie(
            imageUrl: (response.data['poster_path'] != null)
                ? response.data['poster_path']
                : "",
            overview: (response.data['overview'] != null)
                ? response.data['overview']
                : 'Not Available',
            title: (response.data['original_title'] != null)
                ? response.data['original_title']
                : ''));
        notifyListeners();
      }
    } catch (e) {
      fetchMovie();
    }
  }

  Future<void> fetchFiveMovie() {
    _movieList.clear();
    for (int i = 0; i < 5; i++) {
      fetchMovie();
    }

    return Future.value();
  }


fetchMore(){
   for (int i = 0; i < 5; i++) {
      fetchMovie();
    }
}


}
