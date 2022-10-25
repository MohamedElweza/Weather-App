import 'package:the_weather/models/clouds.dart';
import 'package:the_weather/models/details.dart';
import 'package:the_weather/models/system.dart';
import 'package:the_weather/models/weatherdes.dart';
import 'package:the_weather/models/wind.dart';

class SingleforcastRead {
  late int dt;
  late Details main;
  late List<WeatherDes> weather;
  late Clouds clouds;
  late Wind wind;
  late int visibility;
  late double pop;
  late System sys;
  late String dt_txt;

  SingleforcastRead({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dt_txt,
  });
  SingleforcastRead.fromMap(Map<String, dynamic> map) {
    this.dt = map['dt'];
    this.main = Details.fromMap(map['main']);
    this.weather = [];
    (map['weather'] as List).forEach((element) {
      this.weather.add(WeatherDes.fromMap(element));
    });
    this.clouds = Clouds.fromMap(map['clouds']);
    this.wind = Wind.fromMap(map['wind']);
    this.visibility = map['visibility'];
    this.pop = double.parse(map['pop'].toString());
    this.sys = System.fromMap(map['sys']);
    this.dt_txt = map['dt_txt'];
  }
  Map<String, dynamic> toMap() {
    List<Map> tmpList = [];
    this.weather.forEach((element) {
      tmpList.add(element.toMap());
    });
    Map<String, dynamic> map = {
      'dt': this.dt,
      'main': this.main.toMap(),
      'weather': tmpList,
      'clouds': this.clouds.toMap(),
      'wind': this.wind.toMap(),
      'visibility': this.visibility,
      'pop': this.pop,
      'sys': this.sys.toMap(),
      'dt_txt': this.dt_txt,
    };
    return map;
  }
}
