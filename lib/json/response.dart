// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';
/*
code generate
flutter packages pub run build_runner watch
 */


@JsonSerializable()
class BaseResponse extends Object {
  final String message;
  final String cod;
  final int count;

  @JsonKey(name: "list")
  final List<City> cities;

  BaseResponse(this.message, this.cod, this.count, this.cities);


  factory BaseResponse.fromJson(Map<String, dynamic>json)=>_$BaseResponseFromJson(json);
  Map<String, dynamic>toJson() =>_$BaseResponseToJson(this);

}

@JsonSerializable()
class City extends Object {
  final int id;
  final String name;
  final Coord coord;
  final Main main;
  final int dt;
  final Wind wind;
  final Rain rain;
  final Clouds clouds;
  final List<Weather> weather;

  City(this.id, this.name, this.coord, this.main, this.dt, this.wind, this.rain,
      this.clouds, this.weather);

  factory City.fromJson(Map<String, dynamic>json)=>_$CityFromJson(json);
  Map<String, dynamic>toJson() =>_$CityToJson(this);

}

@JsonSerializable()
class Coord extends Object {
  final double lat;
  final double long;

  factory Coord.fromJson(Map<String, dynamic>json)=>_$CoordFromJson(json);
  Map<String, dynamic>toJson() =>_$CoordToJson(this);

  Coord(this.lat, this.long);

}

@JsonSerializable()
class Main extends Object {
  final double temp;
  final int pressure;
  final int humidity;
  @JsonKey(name: "temp_max")
  final int tempMax;
  @JsonKey(name: "temp_min")
  final int tempMin;

  factory Main.fromJson(Map<String, dynamic>json)=>_$MainFromJson(json);
  Map<String, dynamic>toJson() =>_$MainToJson(this);

  Main(this.temp, this.pressure, this.humidity, this.tempMax, this.tempMin);


}

@JsonSerializable()
class Wind extends Object {

  final double speed;
  final int deg;
  final double gust;

  factory Wind.fromJson(Map<String, dynamic>json) =>_$WindFromJson(json);
  Map<String, dynamic>toJson() =>_$WindToJson(this);


  Wind(this.speed, this.deg, this.gust);


}

@JsonSerializable()
class Rain extends Object {
  @JsonKey(name: "3h")
  final double threeHour;

  factory Rain.fromJson(Map<String, dynamic>json) =>_$RainFromJson(json);
  Map<String, dynamic>toJson() =>_$RainToJson(this);

  Rain(this.threeHour);


}

@JsonSerializable()
class Clouds extends Object {

  final int all;

  Clouds(this.all);

  factory Clouds.fromJson(Map<String, dynamic>json)=>_$CloudsFromJson(json);
  Map<String, dynamic>toJson() =>_$CloudsToJson(this);


}

@JsonSerializable()
class Weather extends Object {
  final int id;
  final String main;
  final String description;
  final String icon;


  factory Weather.fromJson(Map<String, dynamic>json)=>_$WeatherFromJson(json);
  Map<String, dynamic>toJson() =>_$WeatherToJson(this);

  Weather(this.id, this.main, this.description, this.icon);


}
