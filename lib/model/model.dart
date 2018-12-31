// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:meta/meta.dart';

class Movie{
  String title;
  String posterPath;
  String id;
  String overview;
  bool favored;

  Movie({
    @required this.title,
    @required this.posterPath,
    @required this.id,
    @required this.overview,
    this.favored
  });
  Movie.fromJson(Map json)
    :title = json['title'],
    posterPath = json['poster_path'],
    id = json['id'].toString(),
    overview = json['overview'],
    favored = false;


}